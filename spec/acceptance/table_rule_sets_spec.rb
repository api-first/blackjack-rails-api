require "api_documentation_helper"

RSpec.resource "Table Rule Sets", :authenticated do
  header "Content-Type", "application/vnd.api+json"

  post "/v1/table-rule-sets" do
    parameter :type, <<-DESC, required: true
      Must always be set to <code>table-rule-sets</code>.
    DESC

    let :type do
      "table-rule-sets"
    end

    let :table_rule_set do
      FactoryGirl.build(:table_rule_set)
    end

    parameter "name", <<-DESC, scope: :attributes
      The name of the rule set. This may be used to describe the type of game
      being offered at a table.
    DESC

    let :name do
      table_rule_set.name
    end

    parameter "deck-count", <<-DESC, required: true, scope: :attributes
      The number of decks that will be used at the table.
    DESC

    let "deck-count" do
      table_rule_set.deck_count
    end

    parameter "player-position-count", <<-DESC, required: true, scope: :attributes
      The number of playing positions at the table. Must be between 5 and 7.
    DESC

    let "player-position-count" do
      table_rule_set.player_position_count
    end

    parameter "maximum-players-per-position", <<-DESC, required: true, scope: :attributes
      The maximum number of players that can play from an individual position on the table.
    DESC

    let "maximum-players-per-position" do
      table_rule_set.maximum_players_per_position
    end

    parameter "maximum-bets-per-player", <<-DESC, required: true, scope: :attributes
      The maximum number of bets that a player can make at a table. This is
      naturally limited by the number of positions, but could be lower.
    DESC

    let "maximum-bets-per-player" do
      table_rule_set.maximum_bets_per_player
    end

    parameter "no-hole-card", <<-DESC, scope: :attributes
      If <code>true</code>, the dealer does not deal themselves a hole card during the initial deal.
      Defaults to <code>false</code>.
    DESC

    let "no-hole-card" do
      table_rule_set.no_hole_card
    end

    parameter "original-bets-only", <<-DESC, scope: :attributes
      This boolean can only be set to true or false if <code>no-hole-card</code> is <code>true</code>.
      When <code>original-bets-only</code> is true, if the player's hand loses to dealer blackjack, only the mandatory
      initial bet is forfeited, and all optional bets (doubles and splits) are pushed.
    DESC

    let "original-bets-only" do
      table_rule_set.original_bets_only
    end

    parameter "initial-player-card-face-up", <<-DESC, scope: :attributes
      This boolean indicates whether the initial card dealt to players is face up.
      It defaults to <code>true</code>.
    DESC

    let "initial-player-card-face-up" do
      table_rule_set.initial_player_card_face_up
    end

    parameter "blackjack-pay-out", <<-DESC, scope: :attributes
      The amount that a winning blackjack hand pays out as a multiple of the original bet.
    DESC

    let "blackjack-pay-out" do
      table_rule_set.blackjack_pay_out
    end

    parameter "standard-pay-out", <<-DESC, scope: :attributes
      The amount that a standard winning hand pays out as a multiple of the original bet.
    DESC

    let "standard-pay-out" do
      table_rule_set.standard_pay_out
    end

    parameter "dealer-stands-at", <<-DESC, scope: :attributes
      The total at which the dealer must stand. Defaults to 17.
    DESC

    let "dealer-stands-at" do
      table_rule_set.dealer_stands_at
    end

    parameter "dealer-draws-if-soft-stand-at", <<-DESC, scope: :attributes
      A boolean that if <code>true</code> requires the dealer to hit on the <code>dealer-stands-at</code>
      total if the total is soft.
    DESC

    let "dealer-draws-if-soft-stand-at" do
      table_rule_set.dealer_draws_if_soft_stand_at
    end

    parameter "surrender", <<-DESC, scope: :attributes
      An enum that indicates whether surrender is offered and if so, how.
      Valid values include <code>not_allowed</code>, <code>early</code>, and <code>late</code>. Defaults to
      <code>not_allowed</code>".
    DESC

    let "surrender" do
      table_rule_set.surrender
    end

    parameter "surrender-percentage", <<-DESC, scope: :attributes
      A decimal that indicates the percentage of the original bet that is surrendered
      when the player makes that choice. Must be <code>NULL</code> if <code>surrender</code> is <code>not_allowed</code>
    DESC

    let "surrender-percentage" do
      table_rule_set.surrender_percentage
    end

    parameter "insurance-available", <<-DESC, scope: :attributes
      A boolean that indicates whether insurance side bets are offered. Defaults to <code>true</code>.
    DESC

    let "insurance-available" do
      table_rule_set.insurance_available
    end

    parameter "insurance-pay-out", <<-DESC, scope: :attributes
      A decimal that is the multiple of the original bet that is paid if an insurance side bet is won.
      Must be <code>NULL</code> if <code>insurance-available</code> is <code>false</code>.
    DESC

    let "insurance-pay-out" do
      table_rule_set.insurance_pay_out
    end

    parameter "dealer-match-available", <<-DESC, scope: :attributes
      A boolean that indicates whether dealer match side bets are offered. Defaults to <code>true</code>.
    DESC

    let "dealer-match-available" do
      table_rule_set.dealer_match_available
    end

    parameter "dealer-match-pay-out", <<-DESC, scope: :attributes
      A decimal that is the multiple of the original bet that is paid if a dealer match side bet is won.
      Must be <code>NULL</code> if <code>dealer-match-available</code> is <code>false</code>.
    DESC

    let "dealer-match-pay-out" do
      table_rule_set.dealer_match_pay_out
    end

    parameter "double-down-minimum-percentage", <<-DESC, scope: :attributes
      A decimal that is the multiple of the original bet that is the minimum bet in "double down" situations.
      Defaults to <code>1.0</code>.
    DESC

    let "double-down-minimum-percentage" do
      table_rule_set.double_down_minimum_percentage.to_s
    end

    parameter "double-down-maximum-percentage", <<-DESC, scope: :attributes
      A decimal that is the multiple of the original bet that is the maximum bet in "double down" situations.
      Defaults to <code>1.0</code>.
    DESC

    let "double-down-maximum-percentage" do
      table_rule_set.double_down_maximum_percentage.to_s
    end

    parameter "split-identical-ranks-only", <<-DESC, scope: :attributes
      A boolean that indicates if a player can only split identical ranks (for example, 2 Jacks)
      or if they can split as long as the value of the rank is the same.
      Defaults to <code>false</code>
    DESC

    let "split-identical-ranks-only" do
      table_rule_set.split_identical_ranks_only
    end

    parameter "maximum-double-count-per-hand", <<-DESC, scope: :attributes
      An integer that indicates the maximum number of times that a player can double down per original hand.
      Defaults to NULL (no maximum).
    DESC

    let "maximum-double-count-per-hand" do
      table_rule_set.maximum_double_count_per_hand
    end

    parameter "maximum-split-count-per-hand", <<-DESC, scope: :attributes
      An integer that indicates the maximum number of times that a player can split per original hand.
      Defaults to NULL (no maximum).
    DESC

    let "maximum-split-count-per-hand" do
      table_rule_set.maximum_split_count_per_hand
    end

    parameter "may-hit-split-aces", <<-DESC, scope: :attributes
      A boolean that indicates if the player may hit, split, or double split aces. Defaults to <code>false</code>.
    DESC

    let "may-hit-split-aces" do
      table_rule_set.may_hit_split_aces
    end

    parameter "non-controlling-player-chooses-split-hand-to-bet-if-not-following", <<-DESC, scope: :attributes
      A boolean that indicates whether a player that does not choose to follow a split by the controlling player
      is allowed to choose which of the split hands to bet. Defaults to <code>false</code> by default.
    DESC

    let "non-controlling-player-chooses-split-hand-to-bet-if-not-following" do
      table_rule_set.non_controlling_player_chooses_split_hand_to_bet_if_not_following
    end

    parameter "player-must-stand-on-soft-21", <<-DESC, scope: :attributes
      A boolean that indicates if a player must stand on a soft 21. Defaults to <code>true</code>.
    DESC

    let "player-must-stand-on-soft-21" do
      table_rule_set.player_must_stand_on_soft_21
    end

    parameter "restrict-doubling-to-hard-totals", <<-DESC, scope: :attributes
      An array that includes the totals that can be doubled. Defaults to <code>NULL</code> (which means there are no restrictions).
    DESC

    let "restrict-doubling-to-hard-totals" do
      table_rule_set.restrict_doubling_to_hard_totals
    end

    parameter "dealer-wins-ties", <<-DESC, scope: :attributes
      A boolean that indicates if a dealer wins tied hands. Otherwise the hands push (nobody wins).
      Defaults to <code>false</code>.
    DESC

    let "dealer-wins-ties" do
      table_rule_set.dealer_wins_ties
    end

    parameter "round-initial-betting-window-seconds", <<-DESC, scope: :attributes
      An integer that indicates the number of seconds that the initial betting window will
      last for each round at the table.
    DESC

    let "round-initial-betting-window-seconds" do
      30
    end

    parameter "minimum-wager-amount", <<-DESC, scope: :attributes
      An integer that indicates the minimum initial wager amount.
    DESC

    let "minimum-wager-amount" do
      25
    end

    example_request "POST /v1/table-rule-sets" do
      expect(status).to eq 201
      parsed = JSON.parse(response_body)
      expect(parsed["data"]["attributes"]["name"]).to eq table_rule_set.name
      expect(parsed["data"]["attributes"]["deck-count"]).to eq table_rule_set.deck_count
      expect(parsed["data"]["attributes"]["player-position-count"]).to eq table_rule_set.player_position_count
      expect(parsed["data"]["attributes"]["maximum-bets-per-player"]).to eq table_rule_set.maximum_bets_per_player
      expect(parsed["data"]["attributes"]["no-hole-card"]).to eq table_rule_set.no_hole_card
      expect(parsed["data"]["attributes"]["original-bets-only"]).to eq table_rule_set.original_bets_only
      expect(parsed["data"]["attributes"]["initial-player-card-face-up"]).to eq table_rule_set.initial_player_card_face_up
      expect(parsed["data"]["attributes"]["blackjack-pay-out"]).to eq table_rule_set.blackjack_pay_out.to_s
      expect(parsed["data"]["attributes"]["standard-pay-out"]).to eq table_rule_set.standard_pay_out.to_s
      expect(parsed["data"]["attributes"]["dealer-stands-at"]).to eq table_rule_set.dealer_stands_at
      expect(parsed["data"]["attributes"]["dealer-draws-if-soft-stand-at"]).to eq table_rule_set.dealer_draws_if_soft_stand_at
      expect(parsed["data"]["attributes"]["surrender"]).to eq table_rule_set.surrender
      expect(parsed["data"]["attributes"]["surrender-percentage"]).to eq table_rule_set.surrender_percentage.to_s
      expect(parsed["data"]["attributes"]["insurance-available"]).to eq table_rule_set.insurance_available
      expect(parsed["data"]["attributes"]["insurance-pay-out"]).to eq table_rule_set.insurance_pay_out.to_s
      expect(parsed["data"]["attributes"]["dealer-match-available"]).to eq table_rule_set.dealer_match_available
      expect(parsed["data"]["attributes"]["dealer-match-pay-out"]).to eq table_rule_set.dealer_match_pay_out.to_s
      expect(parsed["data"]["attributes"]["double-down-minimum-percentage"]).to eq table_rule_set.double_down_minimum_percentage.to_s
      expect(parsed["data"]["attributes"]["double-down-maximum-percentage"]).to eq table_rule_set.double_down_maximum_percentage.to_s
      expect(parsed["data"]["attributes"]["split-identical-ranks-only"]).to eq table_rule_set.split_identical_ranks_only
      expect(parsed["data"]["attributes"]["maximum-double-count-per-hand"]).to eq table_rule_set.maximum_double_count_per_hand
      expect(parsed["data"]["attributes"]["maximum-split-count-per-hand"]).to eq table_rule_set.maximum_split_count_per_hand
      expect(parsed["data"]["attributes"]["may-hit-split-aces"]).to eq table_rule_set.may_hit_split_aces
      expect(parsed["data"]["attributes"]["player-must-stand-on-soft-21"]).to eq table_rule_set.player_must_stand_on_soft_21
      expect(parsed["data"]["attributes"]["restrict-doubling-to-hard-totals"]).to eq table_rule_set.restrict_doubling_to_hard_totals
    end
  end

  get "/v1/table-rule-sets/:id" do
    let! :table_rule_set do
      FactoryGirl.create(:table_rule_set)
    end

    parameter :id, <<-DESC, required: true
      ID of the table rule set to be retrieved.
    DESC

    let :id do
      table_rule_set.id
    end

    example_request "GET /v1/table-rule-sets/:id" do
      expect(status).to eq 200
    end
  end

  get "/v1/table-rule-sets" do
    before do
      FactoryGirl.create(:table_rule_set)
    end

    example_request "GET /v1/table-rule-sets" do
      expect(status).to eq 200
    end
  end

end
