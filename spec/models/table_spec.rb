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

  it "has an array of the valid positions for the table" do
    table_rule_set = TableRuleSet.new(player_position_count: 5)
    subject.table_rule_set = table_rule_set
    expect(subject.positions).to eq [1,2,3,4,5]
  end

  it "has_many table_player_positions" do
    subject.table_player_positions.new
    expect(subject.table_player_positions.size).to eq 1
  end

  it "is open by default" do
    expect(subject).to be_open
  end

  it "destroys all the table_player_positions after it's closed" do
    table = FactoryGirl.create(:table)
    FactoryGirl.create(:table_player_position, table: table)
    table.reload
    expect{table.update!(open: false)}.to change{TablePlayerPosition.count}.by(-1)
  end

  it "has many rounds" do
    expect(subject.rounds.new).to be_a Round
  end

  it "has a current_round" do
    table = FactoryGirl.create(:table)
    old_round = FactoryGirl.create(:round, table: table, active: false, initial_betting_closed_at: Time.utc(2015,10,1,0,0))
    current_round = FactoryGirl.create(:round, table: table, active: true, initial_betting_closed_at: Time.utc(2015,10,1,2,0))
    table.reload
    expect(table.current_round).to eq current_round
  end
end
