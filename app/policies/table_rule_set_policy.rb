class TableRuleSetPolicy < ApplicationPolicy

  def create?
    user.pit_boss?
  end

  alias_method :update?, :create?
  alias_method :destroy?, :create?

  class Scope < Scope
    def resolve
      scope.all
    end
  end

end
