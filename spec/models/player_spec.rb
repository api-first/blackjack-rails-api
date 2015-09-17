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

  it "has many transactions" do
    expect(subject.transactions.new).to be_a Transaction
  end

  it "validates the presence of a user" do
    subject.user = nil
    subject.valid?
    expect(subject.errors[:user]).to include "can't be blank"
  end

  it "is credited with 1000 upon creation" do
    subject = FactoryGirl.create(:player)
    expect(subject.balance).to eq 1000
    # and it doesn't credit them more after being saved again
    subject.touch
    expect(subject.balance).to eq 1000
  end

  it "has a balance that is the sum of the transactions" do
    subject = FactoryGirl.create(:player)
    initial_balance = subject.balance
    FactoryGirl.create(:transaction_deposit, amount: 100, player: subject)
    expect(subject.balance).to eq initial_balance + 100
    FactoryGirl.create(:wager, player: subject, amount: 25)
    expect(subject.balance).to eq initial_balance + 75
    FactoryGirl.create(:transaction_win, amount: 50, player: subject)
    expect(subject.balance).to eq initial_balance + 125
    FactoryGirl.create(:transaction_withdrawal, amount: -125, player: subject)
    expect(subject.balance).to eq initial_balance + 0
  end

  it "has a name attribute" do
    subject.name = "Barney"
    expect(subject.name).to eq "Barney"
  end

  it "initializes with a name" do
    expect(subject.name).not_to be_blank
  end

  it "has a wins attribute" do
    subject.wins = 3
    expect(subject.wins).to eq 3
  end

  it "initializes with wins" do
    expect(subject.wins).not_to be_blank
  end

  it "has a losses attribute" do
    subject.losses = 3
    expect(subject.losses).to eq 3
  end

  it "initializes with losses" do
    expect(subject.losses).not_to be_blank
  end

  it "calculates win percent" do
    subject.wins = 8
    subject.losses = 8
    expect(subject.win_percentage).to eq 50
    subject.wins = 4
    subject.losses = 0
    expect(subject.win_percentage).to eq 100
    subject.wins = 0
    subject.losses = 8
    expect(subject.win_percentage).to eq 0
  end

end
