RSpec.describe Table do

  it "belongs_to table_rule_set" do
    subject.build_table_rule_set
    expect(subject.table_rule_set).to be_a TableRuleSet
  end

  it "validates the presence of table_rule_set" do
    subject.table_rule_set = nil
    subject.valid?
    expect(subject.errors[:table_rule_set]).to include "can't be blank"
  end

  it "delegates player_position_count to table_rule_set" do
    subject.build_table_rule_set(player_position_count: 5)
    expect(subject.player_position_count).to eq subject.table_rule_set.player_position_count
  end

  it "delegates maximum_players_per_position to table_rule_set" do
    subject.build_table_rule_set(maximum_players_per_position: 3)
    expect(subject.maximum_players_per_position).to eq subject.table_rule_set.maximum_players_per_position
  end

  it "has_many table_player_positions" do
    subject.table_player_positions.new
    expect(subject.table_player_positions.size).to eq 1
  end

end
