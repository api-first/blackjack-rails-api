RSpec.describe Transaction do

  it "belongs to a player" do
    expect(subject.build_player).to be_a Player
  end

  it "validates the presence of the player" do
    subject.player = nil
    subject.valid?
    expect(subject.errors[:player]).to include "can't be blank"
  end

  it "validates the presence of kind" do
    subject.kind = nil
    subject.valid?
    expect(subject.errors[:kind]).to include "can't be blank"
  end

  it "belongs to an action" do
    wager = Wager.new
    subject.action = wager
    expect(subject.action).to eq wager
  end

  it "has an amount" do
    subject.amount = "100"
    expect(subject.amount).to eq BigDecimal("100")
  end

  it "has kinds" do
    expect(described_class.kinds).to eq({
      "credit" => 0,
      "deposit" => 1,
      "wager" => 2,
      "win" => 3,
      "withdrawal" => 4,
    })
  end

  context "when the kind is deposit" do
    before do
      subject.kind = :deposit
    end
    it "validates that the amount is greater than 0" do
      subject.amount = 0
      subject.valid?
      expect(subject.errors[:amount]).to include "must be greater than 0"
    end
  end

  context "when the kind is a wager" do
    before do
      subject.kind = :wager
    end
    it "validates that the amount is less than 0" do
      subject.amount = 0
      subject.valid?
      expect(subject.errors[:amount]).to include "must be less than 0"
    end
    it "validates that the action is present" do
      subject.action = nil
      subject.valid?
      expect(subject.errors[:action]).to include "can't be blank"
    end
    it "validates that its action_type is Wager" do
      subject.action_type = "Bet"
      subject.valid?
      expect(subject.errors[:action_type]).to include "must be Wager"
    end
    it "validates that the amount is the negative of the action amount" do
      subject.action = Wager.new(amount: 100)
      subject.amount = -99
      subject.valid?
      expect(subject.errors[:amount]).to include "must be negative of action's amount"
    end
    it "validates that the player is the action player" do
      player = Player.new
      subject.action = Wager.new(player: player)
      subject.player = Player.new
      subject.valid?
      expect(subject.errors[:player]).to include "must be the action's player"
    end
  end

  context "when the kind is a win" do
    before do
      subject.kind = :win
    end
    it "validates that the amount is greater than 0" do
      subject.amount = 0
      subject.valid?
      expect(subject.errors[:amount]).to include "must be greater than 0"
    end
  end

  context "when the kind is a withdrawal" do
    before do
      subject.kind = :withdrawal
    end
    it "validates that the amount is less than 0" do
      subject.amount = 0
      subject.valid?
      expect(subject.errors[:amount]).to include "must be less than 0"
    end
  end

end
