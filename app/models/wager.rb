class Wager < ActiveRecord::Base
  enum kind: [:initial]

  belongs_to :hand

  belongs_to :player

  validates :hand, presence: true

  validates :player, presence: true

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
end
