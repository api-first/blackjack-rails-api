RSpec.describe TablePlayerPosition do
  it "belongs to a table" do
    subject.build_table
    expect(subject.table).to be_a Table
  end

  it "belongs to a player" do
    subject.build_player
    expect(subject.player).to be_a Player
  end

  it "validates the presence of a table" do
    subject.table = nil
    subject.valid?
    expect(subject.errors[:table]).to include "can't be blank"
  end

  it "validates the presence of a player" do
    subject.player = nil
    subject.valid?
    expect(subject.errors[:player]).to include "can't be blank"
  end

  it "validates that the position is greater than or equal to 1" do
    subject.position = 0
    subject.valid?
    expect(subject.errors[:position]).to include "must be greater than or equal to 1"
  end

  it "validates that the position is less than or equal to the maximum_position" do
    expect(subject).to receive(:maximum_position).and_return(5)
    subject.position = 6
    subject.valid?
    expect(subject.errors[:position]).to include "must be less than or equal to 5"
  end

  it "delegates maximum_position to table" do
    table = Table.new
    table.build_table_rule_set(player_position_count: 5)
    subject.table = table
    expect(subject.maximum_position).to eq table.table_rule_set.player_position_count
  end

  it "delegates maximum_players_at_position to the table" do
    table = Table.new
    table.build_table_rule_set(maximum_players_per_position: 3)
    subject.table = table
    expect(subject.maximum_players_at_position).to eq table.table_rule_set.maximum_players_per_position
  end

  it "validates that there is space at the position for the table" do
    expect(subject).to receive(:others_at_position_count).and_return(3)
    expect(subject).to receive(:maximum_players_at_position).and_return(3)
    subject.position = 1
    subject.valid?
    expect(subject.errors[:position]).to include "already has the maximum number of players"
  end

  it "calculates other_players_at_position_count" do
    position = 1
    table = Table.new
    table.table_player_positions.new(position: position)
    subject.table, subject.position = table, position
    expect(subject.others_at_position_count).to eq 1
  end

  it "is controlling if it is in the first order" do
    table = FactoryGirl.create(:table)
    table_player_position_one = FactoryGirl.create(:table_player_position, table: table)
    table_player_position_one.reload
    expect(table_player_position_one).to be_controlling
    table_player_position_two = FactoryGirl.create(:table_player_position, table: table)
    expect(table_player_position_two).not_to be_controlling
  end
end
