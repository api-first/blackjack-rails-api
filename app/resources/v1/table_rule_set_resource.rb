module V1
  class TableRuleSetResource < BaseResource
    attributes(
      :name,
      :deck_count,
      :player_position_count,
      :maximum_players_per_position,
      :maximum_bets_per_player,
      :no_hole_card,
      :original_bets_only,
      :initial_player_card_face_up,
      :blackjack_pay_out,
      :standard_pay_out,
      :dealer_stands_at,
      :dealer_draws_if_soft_stand_at,
      :surrender,
      :surrender_percentage,
      :insurance_available,
      :insurance_pay_out,
      :dealer_match_available,
      :dealer_match_pay_out,
      :double_down_minimum_percentage,
      :double_down_maximum_percentage,
      :split_identical_ranks_only,
      :maximum_double_count_per_hand,
      :maximum_split_count_per_hand,
      :may_hit_split_aces,
      :non_controlling_player_chooses_split_hand_to_bet_if_not_following,
      :player_must_stand_on_soft_21,
      :restrict_doubling_to_hard_totals,
      :dealer_wins_ties,
      :round_initial_betting_window_seconds,
      :minimum_wager_amount
    )

    class << self
      def creatable_fields(context)
        [
          :name,
          :deck_count,
          :player_position_count,
          :maximum_players_per_position,
          :maximum_bets_per_player,
          :no_hole_card,
          :original_bets_only,
          :initial_player_card_face_up,
          :blackjack_pay_out,
          :standard_pay_out,
          :dealer_stands_at,
          :dealer_draws_if_soft_stand_at,
          :surrender,
          :surrender_percentage,
          :insurance_available,
          :insurance_pay_out,
          :dealer_match_available,
          :dealer_match_pay_out,
          :double_down_minimum_percentage,
          :double_down_maximum_percentage,
          :split_identical_ranks_only,
          :maximum_double_count_per_hand,
          :maximum_split_count_per_hand,
          :may_hit_split_aces,
          :non_controlling_player_chooses_split_hand_to_bet_if_not_following,
          :player_must_stand_on_soft_21,
          :restrict_doubling_to_hard_totals,
          :dealer_wins_ties,
          :round_initial_betting_window_seconds,
          :minimum_wager_amount
        ]
      end

      alias_method :updatable_fields, :creatable_fields
    end

  end
end
