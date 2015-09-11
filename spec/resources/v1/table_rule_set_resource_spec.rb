module V1
  RSpec.describe TableRuleSetResource do

    let :creatable_and_updatable_fields do
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
        :minimum_wager_amount,
      ].sort
    end

    it "can create the correct fields" do
      expect(described_class.creatable_fields(nil).sort).to eq creatable_and_updatable_fields
    end

    it "can update the correct fields" do
      expect(described_class.updatable_fields(nil).sort).to eq creatable_and_updatable_fields
    end

    it "can fetch the correct fields" do
      expect(described_class.new(TableRuleSet.new).fetchable_fields.sort).to eq (creatable_and_updatable_fields + [:id, :created_at, :updated_at]).sort
    end

  end
end
