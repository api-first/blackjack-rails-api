RSpec.describe Hand do
  it "belongs_to a round" do
    expect(subject.build_round).to be_a Round
  end

  it "has a position attribute" do
    subject.position = 1
    expect(subject.position).to eq 1
  end

  it "validates that it has a position" do
    subject.position = nil
    subject.valid?
    expect(subject.errors[:position]).to include "can't be blank"
  end

  it "has many wagers" do
    expect(subject.wagers.new).to be_a Wager
  end

  it "has many hand_cards" do
    expect(subject.hand_cards.new).to be_a HandCard
  end

  it "cannot create a hand at a position that does not exist for a table" do
    table = Table.new
    allow(table).to receive(:positions).and_return([1,2,3,4,5])
    round = Round.new(table: table)
    subject.round = round
    subject.position = table.positions.last + 1
    subject.valid?
    expect(subject.errors[:position]).to include "is not included in the list"
  end
end
