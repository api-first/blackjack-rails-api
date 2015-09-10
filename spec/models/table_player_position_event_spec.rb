RSpec.describe TablePlayerPositionEvent do
  it "has a table" do
    subject.build_table
    expect(subject.table).to be_a Table
  end

  it "has a player" do
    subject.build_player
    expect(subject.player).to be_a Player
  end

  it "has a position" do
    subject.position = 1
    expect(subject.position).to eq 1
  end

  it "has join and leave events" do
    expect(described_class.events).to eq({
      "join" => 0,
      "leave" => 1
    })
  end

  it "does not default the event" do
    expect(subject.event).to eq nil
  end
end
