RSpec.describe Hand do
  it "belongs_to a round" do
    expect(subject.build_round).to be_a Round
  end

  it "belongs_to a table_player_position" do
    expect(subject.build_table_player_position).to be_a TablePlayerPosition
  end

  it "has many wagers" do
    expect(subject.wagers.new).to be_a Wager
  end

  it "has many hand_cards" do
    expect(subject.hand_cards.new).to be_a HandCard
  end
end
