RSpec.describe Wager do

  it "belongs to a hand" do
    expect(subject.build_hand).to be_a Hand
  end

  it "belongs to a player" do
    expect(subject.build_player).to be_a Player
  end

  it "validates the presence of a hand" do
    subject.hand = nil
    subject.valid?
    expect(subject.errors[:hand]).to include "can't be blank"
  end

  it "validates the presence of a player" do
    subject.player = nil
    subject.valid?
    expect(subject.errors[:player]).to include "can't be blank"
  end

  it "has an enum of kinds" do
    expect(described_class.kinds).to eq({
      "initial" => 0
    })
  end

  it "can only create an initial bet if the initial betting window is open for the round" do
    wager_at = Time.utc(2015,10,1,1,1)
    round = FactoryGirl.create(:round, initial_betting_closed_at: wager_at - 1.second)
    hand = FactoryGirl.create(:hand, round: round)
    allow(Time).to receive(:now).and_return(wager_at)
    subject.hand = hand
    subject.kind = "initial"
    subject.valid?
    expect(subject.errors[:created_at]).to include "must be placed before the initial betting window is closed"
    round.update!(initial_betting_closed_at: wager_at + 1.second)
    subject.valid?
    expect(subject.errors[:created_at]).to be_empty
  end

  it "can bet a decimal amount" do
    subject.amount = "12.50"
    expect(subject.amount).to eq BigDecimal("12.50")
  end

  it "validates that its amount is greater than or equal to the minimum_wager_amount for the table" do
    expect(subject).to receive(:minimum_amount).and_return(100)
    subject.amount = 99
    subject.valid?
    expect(subject.errors[:amount]).to include "must be greater than or equal to 100"
  end

  it "gets its minimum_amount from the table rule set" do
    table_rule_set = FactoryGirl.build(:table_rule_set, minimum_wager_amount: 100)
    table = FactoryGirl.build(:table, table_rule_set: table_rule_set)
    round = FactoryGirl.build(:round, table: table)
    hand = FactoryGirl.build(:hand, round: round)
    subject.hand = hand
    expect(subject.minimum_amount).to eq 100
  end

  it "has a minimum infinite amount if the hand etc are nil" do
    subject.hand = nil
    expect(subject.minimum_amount).to eq Float::INFINITY
  end

end
