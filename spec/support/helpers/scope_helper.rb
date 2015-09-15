module ScopeHelper
  extend ActiveSupport::Concern

  def stub_scope(policy_class, value)
    scope_class = Class.new(policy_class::Scope.superclass)
    allow_any_instance_of(scope_class).to receive(:resolve).and_return(value)
    stub_const "#{policy_class.name}::Scope", scope_class
  end
end

RSpec.configure do |config|
  config.include ScopeHelper
end
