RSpec.describe Player do

  it "has a has_many relationship to table_player_positions" do
    subject.table_player_positions.new
    expect(subject.table_player_positions.first).to be_a TablePlayerPosition
  end

end
