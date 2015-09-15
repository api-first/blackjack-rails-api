class TablePlayerPositionPolicy < ApplicationPolicy

  def create?
    user == record.player.try(:user)
  end

  alias_method :update?, :create?
  alias_method :destroy?, :create?

  class Scope < Scope
    def resolve
      scope.all
    end
  end

end
