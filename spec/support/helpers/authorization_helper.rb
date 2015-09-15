module AuthorizationHelper
  module Controller
    # Add this method in a before block in a controller spec and the policy matching
    # the model class of the controller will authorize anything.
    def authorize_anything!
      stub_scope policy_class, model_class.all

      [:create?, :show?, :update?, :destroy?, :get_related_resources?].each do |method|
        allow_any_instance_of(policy_class).to receive(method).and_return(true)
      end
    end

    private

    def policy_class
      Pundit::PolicyFinder.new(model_class).policy
    end

    def model_class
      example.metadata[:example_group][:parent_example_group][:description].singularize.constantize
    end
  end
end

RSpec.configure do |config|
  config.include AuthorizationHelper::Controller, type: :acceptance
end
