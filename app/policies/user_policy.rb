class UserPolicy < ApplicationPolicy

  def create?
    true
  end

  alias_method :update?, :show?

  class Scope < Scope
    def resolve
      return scope.all if user.pit_boss?

      scope.where(id: user.id)
    end
  end

end
