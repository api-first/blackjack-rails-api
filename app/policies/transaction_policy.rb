class TransactionPolicy < ApplicationPolicy

  class Scope < Scope
    def resolve
      return scope.all if user.pit_boss?

      scope.where(player_id: user.players.select(:id))
    end
  end

end
