RSpec.describe Round do
  it "belongs to a table" do
    expect(subject.build_table).to be_a Table
  end

  it "has many hands" do
    expect(subject.hands.new).to be_a Hand
  end

  it "validates the presence of table" do
    subject.table = nil
    subject.valid?
    expect(subject.errors[:table]).to include "can't be blank"
  end

  it "sets the initial_betting_closed_at before validation using the related table rule set" do
    now = Time.utc(2015,8,18,12,0,0)
    allow(Time).to receive(:now).and_return(now)
    initial_betting_window_seconds = 30
    table_rule_set = FactoryGirl.build(:table_rule_set, round_initial_betting_window_seconds: initial_betting_window_seconds)
    table = FactoryGirl.build(:table, table_rule_set: table_rule_set)
    subject.table = table
    subject.run_callbacks(:validation)
    expect(subject.initial_betting_closed_at).to eq now.advance(seconds: initial_betting_window_seconds)
  end

  it "validates the presence of initial_betting_closed_at" do
    allow(subject).to receive(:initial_betting_closed_at).and_return(nil)
    subject.valid?
    expect(subject.errors[:initial_betting_closed_at]).to include "can't be blank"
  end

  it "initializes as active" do
    expect(subject).to be_active
  end

  it "can only have one active round for a table at one time" do
    table = FactoryGirl.create(:table)
    FactoryGirl.create(:round, active: true, table: table)
    subject = FactoryGirl.build(:round, active: true, table: table)
    subject.valid?
    expect(subject.errors[:active]).to include "has already been taken"
  end

  it "creates a hand for the player position when the round is created" do
    table_rule_set = FactoryGirl.create(:table_rule_set, minimum_players_per_round: 1)
    table = FactoryGirl.create(:table, table_rule_set: table_rule_set)
    table_player_position = FactoryGirl.create(:table_player_position, table: table)
    expect(table_player_position.hands).not_to be_empty
  end
end
