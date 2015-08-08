RSpec.describe TableRuleSet do

  it "has a name attribute that is nil by default" do
    expect(subject.name).to eq nil
  end

  it "validates the uniqueness of the name" do
    original = FactoryGirl.create(:table_rule_set)
    duplicate = original.dup
    duplicate.valid?
    expect(duplicate.errors[:name]).to include "has already been taken"
  end

  it "has a deck_count" do
    subject.deck_count = 1
    expect(subject.deck_count).to eq 1
  end

  it "validates that the deck_count is greater than or equal to 1" do
    subject.deck_count = 0
    subject.valid?
    expect(subject.errors[:deck_count]).to include "must be greater than 0"
  end

  it "has a player_position_count attribute" do
    player_position_count = 5
    subject.player_position_count = player_position_count
    expect(subject.player_position_count).to eq player_position_count
  end

  it "validates that the player_position_count is greater than or equal to 5" do
    subject.player_position_count = 4
    subject.valid?
    expect(subject.errors[:player_position_count]).to include "must be greater than or equal to 5"
  end

  it "validates that the player_position_count is less than or equal to 7" do
    subject.player_position_count = 8
    subject.valid?
    expect(subject.errors[:player_position_count]).to include "must be less than or equal to 7"
  end

  it "has a maximum_players_per_position attribute" do
    maximum_players_per_position = 2
    subject.maximum_players_per_position = maximum_players_per_position
    expect(subject.maximum_players_per_position).to eq maximum_players_per_position
  end

  it "validates that the maximum_players_per_position greater than or equal to 1" do
    subject.maximum_players_per_position = 0
    subject.valid?
    expect(subject.errors[:maximum_players_per_position]).to include "must be greater than or equal to 1"
  end

  it "validates that the maximum_players_per_position less than or equal to 13" do
    subject.maximum_players_per_position = 4
    subject.valid?
    expect(subject.errors[:maximum_players_per_position]).to include "must be less than or equal to 3"
  end

  it "has a maximum_bets_per_player" do
    maximum_bets_per_player = 2
    subject.maximum_bets_per_player = maximum_bets_per_player
    expect(subject.maximum_bets_per_player).to eq maximum_bets_per_player
  end

  it "validates that the maximum_bets_per_player is greater than or equal to 1" do
    subject.maximum_bets_per_player = 0
    subject.valid?
    expect(subject.errors[:maximum_bets_per_player]).to include "must be greater than or equal to 1"
  end

  it "has a no_hole_card attribute that defaults to false" do
    expect(subject.no_hole_card).to eq false
  end

  it "has an original_bets_only that defaults to nil" do
    expect(subject.original_bets_only).to eq nil
  end

  it "original_bets_only must be nil if no_hole_card is false" do
    subject.no_hole_card = false
    [false, true].each do |original_bets_only|
      subject.original_bets_only = original_bets_only
      subject.valid?
      expect(subject.errors[:original_bets_only]).to include "must be nil unless original_bets_only is true"
    end
  end

  it "original_bets_only must be true or false if no_hole_card is true" do
    subject.no_hole_card = true
    subject.original_bets_only = nil
    subject.valid?
    expect(subject.errors[:original_bets_only]).to include "must be true or false if original_bets_only is true"
  end

  it "has an initial_player_card_face_up attribute that defaults to true" do
    expect(subject.initial_player_card_face_up).to eq true
  end

  it "has a blackjack_pay_out attribute that is a decimal" do
    blackjack_pay_out = "1.5"
    subject.blackjack_pay_out = blackjack_pay_out
    expect(subject.blackjack_pay_out).to eq BigDecimal(blackjack_pay_out)
  end

  it "validates that blackjack_pay_out is greater than 0" do
    subject.blackjack_pay_out = 0
    subject.valid?
    expect(subject.errors[:blackjack_pay_out]).to include "must be greater than 0"
  end

  it "has a standard_pay_out attribute that is a decimal" do
    standard_pay_out = "1.0"
    subject.standard_pay_out = standard_pay_out
    expect(subject.standard_pay_out).to eq BigDecimal(standard_pay_out)
  end

  it "validates that standard_pay_out is greater than 0" do
    subject.standard_pay_out = "0"
    subject.valid?
    expect(subject.errors[:standard_pay_out]).to include "must be greater than 0"
  end

  it "has a dealer_stands_at attribute that defaults to 17" do
    expect(subject.dealer_stands_at).to eq 17
  end

  it "validates that the dealer_stands_at is greater than or equal to 12" do
    subject.dealer_stands_at = 11
    subject.valid?
    expect(subject.errors[:dealer_stands_at]).to include "must be greater than or equal to 12"
  end

  it "validates that the dealer_stands_at is less than or equal to 21" do
    subject.dealer_stands_at = 22
    subject.valid?
    expect(subject.errors[:dealer_stands_at]).to include "must be less than or equal to 21"
  end

  it "has a dealer_draws_if_soft_stand_at that defaults to false" do
    expect(subject.dealer_draws_if_soft_stand_at).to eq false
  end

  it "validates that dealer_draws_if_soft_stand_at is not nil" do
    subject.dealer_draws_if_soft_stand_at = nil
    subject.valid?
    expect(subject.errors[:dealer_draws_if_soft_stand_at]).to include "must be true or false"
  end

  it "has a surrender enum with valid values of early, late, or not_allowed" do
    expect(described_class.surrenders).to eq({ "not_allowed" => 0, "early" => 1, "late" => 2 })
  end

  it "defaults surrender to 'not_allowed'" do
    expect(subject.surrender).to eq "not_allowed"
  end

  it "has a surrender_percentage that is a decimal" do
    surrender_percentage = "0.5"
    subject.surrender_percentage = surrender_percentage
    expect(subject.surrender_percentage).to eq BigDecimal(surrender_percentage)
  end

  it "validates that surrender_percentage is nil if surrender is not_allowed" do
    subject.surrender = "not_allowed"
    subject.surrender_percentage = "0.5"
    subject.valid?
    expect(subject.errors[:surrender_percentage]).to include "must be nil if surrender is not allowed"
  end

  it "validates that surrender_percentage is greater than 0 if surrender is early or late" do
    ["early", "late"].each do |surrender|
      subject.surrender = surrender
      subject.surrender_percentage = "0"
      subject.valid?
      expect(subject.errors[:surrender_percentage]).to include "must be greater than 0"
    end
  end

  it "validates that surrender_percentage is less than 1 if surrender is early or late" do
    ["early", "late"].each do |surrender|
      subject.surrender = surrender
      subject.surrender_percentage = "1"
      subject.valid?
      expect(subject.errors[:surrender_percentage]).to include "must be less than 1"
    end
  end

  it "has a insurance_available attribute that defaults to true" do
    expect(subject.insurance_available).to eq true
  end

  it "validates that insurance_available is either true or false" do
    subject.insurance_available = nil
    subject.valid?
    expect(subject.errors[:insurance_available]).to include "must be true or false"
  end

  it "has a insurance_pay_out attribute that is a decimal" do
    insurance_pay_out = "2.0"
    subject.insurance_pay_out = insurance_pay_out
    expect(subject.insurance_pay_out).to eq BigDecimal(insurance_pay_out)
  end

  it "validates that insurance_pay_out is greater than 0 if insurance_available is true" do
    subject.insurance_available = true
    subject.insurance_pay_out = 0
    subject.valid?
    expect(subject.errors[:insurance_pay_out]).to include "must be greater than 0"
  end

  it "validates that insurance_pay_out is nil if insurance_available is false" do
    subject.insurance_available = false
    subject.insurance_pay_out = "2.0"
    subject.valid?
    expect(subject.errors[:insurance_pay_out]).to include "must be nil if insurance_available is false"
  end

  it "has a dealer_match_available attribute that defaults to true" do
    expect(subject.dealer_match_available).to eq true
  end

  it "validates that dealer_match_available is true or false" do
    subject.dealer_match_available = nil
    subject.valid?
    expect(subject.errors[:dealer_match_available]).to include "must be true or false"
  end

  it "has a dealer_match_pay_out atribute that is a decimal" do
    dealer_match_pay_out = "2.0"
    subject.dealer_match_pay_out = dealer_match_pay_out
    expect(subject.dealer_match_pay_out).to eq BigDecimal(dealer_match_pay_out)
  end

  it "validates that the dealer_match_pay_out is nil if dealer_match_available = false" do
    subject.dealer_match_available = false
    subject.dealer_match_pay_out = "2.0"
    subject.valid?
    expect(subject.errors[:dealer_match_pay_out]).to include "must be nil if dealer_match_available is false"
  end

  it "validates that the dealer_match_pay_out is greater than 0 if dealer_match_available is true" do
    subject.dealer_match_available = true
    subject.dealer_match_pay_out = 0
    subject.valid?
    expect(subject.errors[:dealer_match_pay_out]).to include "must be greater than 0"
  end

  it "has a double_down_minimum_percentage attribute that's a decimal" do
    double_down_minimum_percentage = "1.0"
    subject.double_down_minimum_percentage = double_down_minimum_percentage
    expect(subject.double_down_minimum_percentage).to eq BigDecimal(double_down_minimum_percentage)
  end

  it "has a default double_down_minimum_percentage of 1.0" do
    expect(subject.double_down_minimum_percentage).to eq BigDecimal("1.0")
  end

  it "validates that the double_down_minimum_percentage is greater than 0" do
    subject.double_down_minimum_percentage = "0"
    subject.valid?
    expect(subject.errors[:double_down_minimum_percentage]).to include "must be greater than 0"
  end

  it "has a double_down_maximum_percentage that's a decimal" do
    double_down_maximum_percentage = "1.0"
    subject.double_down_maximum_percentage = double_down_maximum_percentage
    expect(subject.double_down_maximum_percentage).to eq BigDecimal(double_down_maximum_percentage)
  end

  it "has a default double_down_maximum_percentage of 1.0" do
    expect(subject.double_down_maximum_percentage).to eq BigDecimal("1.0")
  end

  it "validates that the double_down_maximum_percentage is greater than 0" do
    subject.double_down_maximum_percentage = "0"
    subject.valid?
    expect(subject.errors[:double_down_maximum_percentage]).to include "must be greater than 0"
  end

  it "validates that the double_down_maximum_percentage is greater than or equal to the double_down_minimum_percentage" do
    subject.double_down_maximum_percentage = "1.0"
    subject.double_down_minimum_percentage = "1.1"
    subject.valid?
    expect(subject.errors[:double_down_maximum_percentage]).to include "must be greater than or equal to the double down minimum percentage"
  end

  it "has a split_identical_ranks_only attribute that is false by default" do
    expect(subject.split_identical_ranks_only).to eq false
  end

  it "validates that the split_identical_ranks_only is true or false" do
    subject.split_identical_ranks_only = nil
    subject.valid?
    expect(subject.errors[:split_identical_ranks_only]).to include "must be true or false"
  end

  it "has a maximum_double_count_per_hand attribute that is nil by default" do
    expect(subject.maximum_double_count_per_hand).to eq nil
  end

  it "allows maximum_double_count_per_hand to be nil" do
    subject.maximum_double_count_per_hand = nil
    subject.valid?
    expect(subject.errors[:maximum_double_count_per_hand]).to be_empty
  end

  it "validates that maximum_double_count_per_hand is greater than or equal to 0" do
    subject.maximum_double_count_per_hand = -1
    subject.valid?
    expect(subject.errors[:maximum_double_count_per_hand]).to include "must be greater than or equal to 0"
  end

  it "has a maximum_split_count_per_hand attribute that is nil by default" do
    expect(subject.maximum_split_count_per_hand).to eq nil
  end

  it "allows maximum_split_count_per_hand to be nil" do
    subject.maximum_split_count_per_hand = nil
    subject.valid?
    expect(subject.errors[:maximum_split_count_per_hand]).to be_empty
  end

  it "validates that maximum_split_count_per_hand is greater than or equal to 0" do
    subject.maximum_split_count_per_hand = -1
    subject.valid?
    expect(subject.errors[:maximum_split_count_per_hand]).to include "must be greater than or equal to 0"
  end

  it "has a may_hit_split_aces attribute that defaults to false" do
    expect(subject.may_hit_split_aces).to eq false
  end

  it "validates that may_hit_split_aces is true or false" do
    subject.may_hit_split_aces = nil
    subject.valid?
    expect(subject.errors[:may_hit_split_aces]).to include "must be true or false"
  end

  it "has attribute non_controlling_player_chooses_split_hand_to_bet_if_not_following that is false by default" do
    expect(subject.non_controlling_player_chooses_split_hand_to_bet_if_not_following).to eq false
  end

  it "validates that non_controlling_player_chooses_split_hand_to_bet_if_not_following is true or false" do
    subject.non_controlling_player_chooses_split_hand_to_bet_if_not_following = nil
    subject.valid?
    expect(subject.errors[:non_controlling_player_chooses_split_hand_to_bet_if_not_following]).to include "must be true or false"
  end

  it "has attribute player_must_stand_on_soft_21 that defaults to true" do
    expect(subject.player_must_stand_on_soft_21).to eq true
  end

  it "validates that player_must_stand_on_soft_21 is true or false" do
    subject.player_must_stand_on_soft_21 = nil
    subject.valid?
    expect(subject.errors[:player_must_stand_on_soft_21]).to include "must be true or false"
  end

  it "has restrict_doubling_to_hard_totals attribute that defaults to nil" do
    expect(subject.restrict_doubling_to_hard_totals).to eq nil
  end

  it "validates that restrict_doubling_to_hard_totals has no members that are less than 2" do
    subject.restrict_doubling_to_hard_totals = [1]
    subject.valid?
    expect(subject.errors[:restrict_doubling_to_hard_totals]).to include "must not contain any values less than 2 or greater than 21"
  end

  it "validates that restrict_doubling_to_hard_totals has no members that are greater than 21" do
    subject.restrict_doubling_to_hard_totals = [22]
    subject.valid?
    expect(subject.errors[:restrict_doubling_to_hard_totals]).to include "must not contain any values less than 2 or greater than 21"
  end

  it "validates that restrict_doubling_to_hard_totals is valid if the members are all between 2 and 21" do
    subject.restrict_doubling_to_hard_totals = (2..21).to_a
    subject.valid?
    expect(subject.errors[:restrict_doubling_to_hard_totals]).to be_empty
  end

  it "has a dealer_wins_ties attribute that defaults to false" do
    expect(subject.dealer_wins_ties).to eq false
  end

  it "validates that dealer_wins_ties is either true or false" do
    subject.dealer_wins_ties = nil
    subject.valid?
    expect(subject.errors[:dealer_wins_ties]).to include "must be true or false"
  end
end
