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
    expect(subject.errors[:position]).to include "is not included in the list"
  end

  it "validates that the position is less than or equal to the maximum_position" do
    expect(subject).to receive(:table_positions).and_return((1..5).to_a)
    subject.position = 6
    subject.valid?
    expect(subject.errors[:position]).to include "is not included in the list"
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

  it "creates events when created and destroyed" do
    table = FactoryGirl.create(:table)
    player = FactoryGirl.create(:player)
    position = 1
    subject = FactoryGirl.create(:table_player_position, table: table, player: player, position: position)
    subject.destroy!
    join_event = TablePlayerPositionEvent.find_by(table_id: table.id, player_id: player.id, position: position, event: TablePlayerPositionEvent.events["join"])
    leave_event = TablePlayerPositionEvent.find_by(table_id: table.id, player_id: player.id, position: position, event: TablePlayerPositionEvent.events["leave"])
    expect(join_event).not_to be_nil
    expect(leave_event).not_to be_nil
  end

  it "has many hands" do
    subject = FactoryGirl.build(:table_player_position)
    expect(subject.hands.count).to eq 0
    subject.save
    expect(subject.hands.count).to eq 1
  end

  it "has many current_hands" do
    subject = FactoryGirl.create(:table_player_position)
    expect(subject.current_hands.count).to eq 1
  end

  it "creates a round for the table if there are none and the minimum positions is met" do
    table_rule_set = FactoryGirl.create(:table_rule_set, minimum_players_per_round: 1)
    table = FactoryGirl.create(:table, table_rule_set: table_rule_set)
    FactoryGirl.create(:table_player_position, table: table)
    table.reload
    expect(table.current_round).not_to be_nil
  end

  it "creates hands for new positions when it should" do
    table_rule_set = FactoryGirl.create(:table_rule_set, minimum_players_per_round: 1)
    table = FactoryGirl.create(:table, table_rule_set: table_rule_set)
    # it creates an initial hand for the first player
    FactoryGirl.create(:table_player_position, table: table, position: 1)
    expect(table.reload.current_round.hands.count).to eq 1

    # it does not create an additional hand when there's a player at the same position
    FactoryGirl.create(:table_player_position, table: table, position: 1)
    expect(table.reload.current_round.hands.count).to eq 1

    # it creates a new hand when a player joins at a new position
    FactoryGirl.create(:table_player_position, table: table, position: 2)
    expect(table.reload.current_round.hands.count).to eq 2

    # it does not create a new hand when the initial betting window has closed
    table.current_round.update_column(:initial_betting_closed_at, Time.now)
    FactoryGirl.create(:table_player_position, table: table, position: 3)
    expect(table.reload.current_round.hands.count).to eq 2
  end
end
