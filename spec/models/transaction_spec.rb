RSpec.describe Transaction do

  it "belongs to a player" do
    expect(subject.build_player).to be_a Player
  end

  it "validates the presence of the player" do
    subject.player = nil
    subject.valid?
    expect(subject.errors[:player]).to include "can't be blank"
  end

  it "has an amount" do
    subject.amount = "100"
    expect(subject.amount).to eq BigDecimal("100")
  end

end
