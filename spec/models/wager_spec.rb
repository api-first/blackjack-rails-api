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

end
