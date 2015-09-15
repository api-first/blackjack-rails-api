class PlayerPolicy < ApplicationPolicy

  def create?
    record.user == user
  end
  alias_method :update?, :create?
  alias_method :destroy?, :create?

  class Scope < Scope
    def resolve
      scope.all
    end
  end

end
