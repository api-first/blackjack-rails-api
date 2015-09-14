class Transaction < ActiveRecord::Base
  belongs_to :player

  belongs_to :action, polymorphic: true

  enum kind: [:credit, :deposit, :wager, :win, :withdrawal]

  validates :player, presence: true

  validates :kind, presence: true

  with_options if: :deposit? do
    validates :amount, numericality: { greater_than: 0 }
  end

  with_options if: :wager? do
    validates :amount, numericality: { less_than: 0 }
    validates :action, presence: true
    validates :action_type, inclusion: { in: ["Wager"], message: "must be Wager" }
    validate :_amount_is_negative_of_action_amount
    validate :_player_is_the_action_player
  end

  with_options if: :win? do
    validates :amount, numericality: { greater_than: 0 }
  end

  with_options if: :withdrawal? do
    validates :amount, numericality: { less_than: 0 }
  end

  def _amount_is_negative_of_action_amount
    unless amount && action.try(:amount) == (-1 * amount)
      errors.add :amount, "must be negative of action's amount"
    end
  end

  def _player_is_the_action_player
    unless action.try(:player) == player
      errors.add :player, "must be the action's player"
    end
  end
end
