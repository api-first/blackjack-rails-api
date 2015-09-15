RSpec.describe User do
  it "has a username attribute" do
    subject.username = "sean"
    expect(subject.username).to eq "sean"
  end

  it "validates the presence of username" do
    subject.username = nil
    subject.valid?
    expect(subject.errors[:username]).to include "can't be blank"
  end

  it "has the pit_boss attribute" do
    subject.pit_boss = true
    expect(subject).to be_pit_boss
  end

  it "creates with a password and can authenticate" do
    user = FactoryGirl.create(:user, username: "sean", password: "drowssap")
    expect(user.authenticate("drowssap")).to eq user
    expect(user.authenticate("--------")).to eq false
  end

  it "has many players" do
    expect(subject.players.new).to be_a Player
  end
end
