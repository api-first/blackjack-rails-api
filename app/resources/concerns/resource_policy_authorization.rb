module ResourcePolicyAuthorization
  extend ActiveSupport::Concern

  included do
    [:save, :remove].each do |action|
      set_callback action, :before, :authorize
    end
  end

  delegate :authorize_policy, to: :class

  def authorize
    authorize_policy(context[:current_user], @model, context[:controller])
  end

  def records_for(association_name, options={})
    records = @model.public_send(association_name)

    return records if context.nil?

    if records
      authorize_policy(context[:current_user], records, context[:controller])
    end
    records
  end

  class_methods do
    def records(options = {})
      records_base = options.fetch(:records_base) { super }
      context = options.fetch(:context) { Hash.new }
      authorized_records(context[:current_user], records_base, context[:controller])
    end

    def authorized_records(user, records, controller)
      records = Pundit.policy_scope!(user, records)
      controller.try :policy_scoped!

      authorize_policy(user, records, controller)

      records
    end

    def authorize_policy(user, records, controller)
      controller.try :policy_authorized!

      case records
      when ActiveRecord::Relation
        return if records.count == 0
      end

      policy = Pundit.policy!(user, policy_record_for(records))
      permission = permission_for(controller, policy)

      if !_authorized?(policy, permission)
        raise Pundit::NotAuthorizedError.new(
          query: permission_for(controller, policy),
          record: policy_record_for(records)
        )
      end
    end

    private

    def policy_record_for(records)
      case records
      when ActiveRecord::Base then records
      when ActiveRecord::Relation then records.first || records.model
      end
    end

    def permission_for(controller, policy)
      if controller && controller.model_class == policy.model_class
        controller.action_name.to_s + "?"
      else
        "show?"
      end
    end

    def _authorized?(policy, permission)
      policy.public_send(permission)
    end

  end
end
