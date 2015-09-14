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

end
