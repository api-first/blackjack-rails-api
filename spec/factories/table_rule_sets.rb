FactoryGirl.define do
  factory :table_rule_set do
    name "Standard Casino"
    deck_count 6
    player_position_count 6
    maximum_players_per_position 3
    maximum_bets_per_player 6
    no_hole_card false
    original_bets_only nil
    initial_player_card_face_up true
    blackjack_pay_out "1.5"
    standard_pay_out "1.0"
    dealer_stands_at 17
    dealer_draws_if_soft_stand_at false
    surrender "late"
    surrender_percentage "0.5"
    insurance_available true
    insurance_pay_out "2.0"
    dealer_match_available true
    dealer_match_pay_out "2.0"
    double_down_minimum_percentage "1.0"
    double_down_maximum_percentage "1.0"
    split_identical_ranks_only false
    maximum_double_count_per_hand nil
    maximum_split_count_per_hand nil
    may_hit_split_aces false
    non_controlling_player_chooses_split_hand_to_bet_if_not_following false
    player_must_stand_on_soft_21 true
    restrict_doubling_to_hard_totals nil
    dealer_wins_ties false
  end
end
