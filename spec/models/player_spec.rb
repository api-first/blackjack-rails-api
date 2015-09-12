RSpec.describe Player do

  it "has a has_many relationship to table_player_positions" do
    subject.table_player_positions.new
    expect(subject.table_player_positions.first).to be_a TablePlayerPosition
  end

  it "has many wagers" do
    expect(subject.wagers.new).to be_a Wager
  end

  it "belongs to a user" do
    expect(subject.build_user).to be_a User
  end

  it "validates the presence of a user" do
    subject.user = nil
    subject.valid?
    expect(subject.errors[:user]).to include "can't be blank"
  end

end
