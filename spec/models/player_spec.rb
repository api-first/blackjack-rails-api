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

  it "has an avatar" do
    subject.avatar = "
/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBggGBQkIEhQQCRUKDRwWGRgXDRwTFBgiHCQhIB4THhsYJzIfGBovJR4mJjsmLyc1LDA4Fio9NzwqOjI3MzUBCQoKDQsNGQ4OGTUkHiQ1NTU1NTU1NTA1NTU1LzU1NTQ1NTQ0NC81MDE1NCk1LzQ0LjA1LDY0LDQ1NC80Lyw2Kf/AABEIADIAMgMBIgACEQEDEQH/xAAcAAEAAgMBAQEAAAAAAAAAAAAABQcBBAYDCAL/xAA2EAABAwMBAwoBDQAAAAAAAAABAAIDBAURBiFBYQcSFDFRUmJxgZKxEyIkQ3J0oaKywcLR8P/EABkBAAIDAQAAAAAAAAAAAAAAAAQGAAEDBf/EAB0RAAICAgMBAAAAAAAAAAAAAAEDAAIEERMxURL/2gAMAwEAAhEDEQA/ALxWvX10NtoJqt55rYWFx7fIcVsLj+VGqdBpRkQOPl6hrTxABd8QFqlfIwU9mOQziVa/gnE3vXd3u1S9zZH0bM7GRvLdnFw2uP4cFpUOq71b5myNnldg9TpC9p9HbFEomgJWK/IqNRNOQ21vo2O5eGldRR6ks7anAjew817ew9o8J/3UplVhyTVLm3itps7JIA7H2SBn8ys9LmWoKaajqNmE4vQL27hERCwyFyPKfRuqdKCUbejTtcfI5b8XBdcvKqpYq2klp3jntlaWkdoK1SzjYL+TF6+Vdqez57RSepLMLDfJqIPE4ZtB34O4+JaFPCaipjhBDTI4NyTgDOzJO4JsrYWr9DqJNqWrY0Pc7jkmpHOuldV7o4Qz3HP8VZqi9OWODT9mipG4eetzu849bvLcOAUolfKaHNNh1HHDSUJFD3CIiGhch77qu2aebiV3OeRkMaOc8+nUB5qub9yiXO7B0Mf0GM7mn5583f1hOUwEawfxhb+65RMGJiKFAwjZMV87NcWWWDoDyCcnPWiIunOTJyw6yulgcGsd8tGPq35LfTe302easjT+vbZfXsgOaSV+wMcdhPY13UfXB4Km1u2Tbf6D7yz9QQWRiKaDbWjOhi5zkkVB2PDL8RESzG6fh8UchyQHY7RlY6ND3W+0LCK9mVoTPRoe632hOjQ91vtCwimzJoTPRoe632hBBE0ghrRjwhEU2ZNCeiIiqXP/2Q=="
    expect(subject.avatar).not_to be_blank
  end

  it "initializes with default avatar" do
    expect(subject.avatar).not_to be_blank
  end
end
