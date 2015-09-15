# This module acts like Pundit but provides
# methods to make verification easier when authorization
# is done within a JSONAPI::Resource.
module PolicyAuthorization
  extend ActiveSupport::Concern

  included do
    class PolicyAuthorizationNotPerformedError < StandardError; end
    class PolicyScopingNotPerformedError < PolicyAuthorizationNotPerformedError; end

    after_action :verify_policy_authorized, except: [:index]
    after_action :verify_policy_scoped, only: [:index]

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    hide_action(
      :policy_authorized!,
      :policy_scoped!,
      :policy_authorized?,
      :policy_scoped?,
    )
  end

  # Indicate that a policy has been authorized on this controller.
  def policy_authorized!
    @policy_authorized = true
  end

  # Indicate that a policy scope has been used in this controller.
  def policy_scoped!
    @policy_scoped = true
  end

  def policy_authorized?
    !!@policy_authorized
  end

  def policy_scoped?
    !!@policy_scoped
  end

private
  # How to respond when the user is not authorized
  # to perform the action. Override in a subclass if
  # when you'd like different behavior.
  def user_not_authorized
    head :forbidden
  end

  def verify_policy_authorized
    raise PolicyAuthorizationNotPerformedError unless policy_authorized?
  end

  def verify_policy_scoped
    raise PolicyScopingNotPerformedError unless policy_scoped?
  end
end
