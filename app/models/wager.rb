class Wager < ActiveRecord::Base
  enum kind: [:initial]

  belongs_to :hand

  belongs_to :player

  has_one :financial_transaction, class_name: "Transaction", as: :action, validate: true

  validates :hand, presence: true

  validates :player, presence: true

  validate :_wager_is_less_than_maximum_wager_amount

  def maximum_wager_amount
    return Float::INFINITY unless hand && hand.round && hand.round.table && hand.round.table.table_rule_set
    hand.round.table.table_rule_set.maximum_wager_amount
  end 

  def _wager_is_less_than_maximum_wager_amount
    if self.amount > maximum_wager_amount
      errors.add ("amount must be less than or equal to the maxium_wager_amount #{maximum_wager_amount}")
    end
  end



  before_validation :build_matching_financial_transaction

  def minimum_amount
    return Float::INFINITY unless hand && hand.round && hand.round.table && hand.round.table.table_rule_set

    hand.round.table.table_rule_set.minimum_wager_amount
  end

  with_options if: :initial? do
    validate :_before_the_end_of_the_intitial_betting_window
    validates :amount, numericality: { greater_than_or_equal_to: :minimum_amount }
  end

  def _before_the_end_of_the_intitial_betting_window
    return unless hand && hand.round

    if hand.round.initial_betting_closed_at <= Time.now
      errors.add :created_at, "must be placed before the initial betting window is closed"
    end
  end

  def _wager_at
    Time.now
  end

  def build_matching_financial_transaction
    return unless amount && player

    build_financial_transaction(amount: (-1 * amount), player: player, kind: :wager, action: self)
  end

end
