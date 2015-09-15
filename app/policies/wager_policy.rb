class WagerPolicy < ApplicationPolicy

  def create?
    record.player.try(:user) == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
