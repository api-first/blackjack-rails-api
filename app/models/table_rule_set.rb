class TableRuleSet < ActiveRecord::Base

  alias_attribute :non_controlling_player_chooses_split_hand_to_bet_if_not_following, :non_controlling_player_chooses_split_hand_to_bet_if_not_followi

  serialize :restrict_doubling_to_hard_totals, JSON

  validates :name, uniqueness: true

  validates :deck_count, numericality: { greater_than: 0 }

  validates :player_position_count, numericality: { greater_than_or_equal_to: 5, less_than_or_equal_to: 7 }

  validates :maximum_players_per_position, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 3  }

  validates :maximum_bets_per_player, numericality: { greater_than_or_equal_to: 1 }

  with_options unless: :no_hole_card do
    validates :original_bets_only, inclusion: { in: [nil], message: "must be nil unless no_hole_card is true" }
  end

  with_options if: :no_hole_card do
    validates :original_bets_only, inclusion: { in: [true, false], message: "must be true or false if no_hole_card is true" }
  end

  validates :blackjack_pay_out, numericality: { greater_than: 0 }

  validates :standard_pay_out, numericality: { greater_than: 0 }

  validates :dealer_stands_at, numericality: { greater_than_or_equal_to: 12, less_than_or_equal_to: 21 }

  validates :dealer_draws_if_soft_stand_at, boolean: true

  with_options if: -> { surrender == "not_allowed" } do
    validates :surrender_percentage, inclusion: { in: [nil], message: "must be nil if surrender is not allowed" }
  end

  with_options if: -> { ["early", "late"].any? { |value| surrender == value } } do
    validates :surrender_percentage, numericality: { greater_than: 0, less_than: 1 }
  end

  validates :insurance_available, boolean: true

  with_options if: :insurance_available do
    validates :insurance_pay_out, numericality: { greater_than: 0 }
  end

  with_options unless: :insurance_available do
    validates :insurance_pay_out, inclusion: { in: [nil], message: "must be nil if insurance_available is false" }
  end

  validates :dealer_match_available, boolean: true

  with_options unless: :dealer_match_available do
    validates :dealer_match_pay_out, inclusion: { in: [nil], message: "must be nil if dealer_match_available is false" }
  end

  with_options if: :dealer_match_available do
    validates :dealer_match_pay_out, numericality: { greater_than: 0 }
  end

  validates :double_down_minimum_percentage, numericality: { greater_than: 0 }

  validates :double_down_maximum_percentage, numericality: { greater_than: 0 }

  validate :_double_down_maximum_percentage_greater_than_or_equal_to_double_down_minimum_percentage

  validates :split_identical_ranks_only, boolean: true

  validates :maximum_double_count_per_hand, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  validates :maximum_split_count_per_hand, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  validates :may_hit_split_aces, boolean: true

  validates :non_controlling_player_chooses_split_hand_to_bet_if_not_following, inclusion: { in: [true, false], message: "must be true or false" }

  validates :player_must_stand_on_soft_21, boolean: true

  validate :_restrict_doubling_to_hard_totals_includes_integers_between_2_and_21

  validates :dealer_wins_ties, boolean: true

  enum surrender: [:not_allowed, :early, :late]

  def _double_down_maximum_percentage_greater_than_or_equal_to_double_down_minimum_percentage
    unless double_down_maximum_percentage >= double_down_minimum_percentage
      errors.add :double_down_maximum_percentage, "must be greater than or equal to the double down minimum percentage"
    end
  end

  def _restrict_doubling_to_hard_totals_includes_integers_between_2_and_21
    unless Array(restrict_doubling_to_hard_totals).all? { |i| i >= 2 && i <= 21 }
      errors.add :restrict_doubling_to_hard_totals, "must not contain any values less than 2 or greater than 21"
    end
  end

end
