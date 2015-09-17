RSpec.describe User do
  it "has a username attribute" do
    subject.username = "sean"
    expect(subject.username).to eq "sean"
  end

  it "has an email attribute" do
    subject.email = "david@example.com"
    expect(subject.email).to eq "david@example.com"
  end

  it "validates the presence of username" do
    subject.username = nil
    subject.valid?
    expect(subject.errors[:username]).to include "can't be blank"
  end

  it "does not enforce the presence of email" do
    subject.email = nil
    subject.valid?
    expect(subject.errors[:email]).to be_empty
  end

  it "validates email format if any" do
    subject.email = "invalid"
    subject.valid?
    expect(subject.errors[:email]).to include "is invalid"
    subject.email = "david@example.com"
    subject.valid?
    expect(subject.errors[:email]).to be_empty
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

  it "validates the uniqueness of username" do
    original = FactoryGirl.create(:user)
    duplicate = FactoryGirl.build(:user, username: original.username)
    duplicate.valid?
    expect(duplicate.errors[:username]).to include "has already been taken"
  end

  it "has a unique index on username in the database" do
    original = FactoryGirl.create(:user, username: "foo")
    duplicate = FactoryGirl.create(:user, username: "bar")
    expect{duplicate.update_column(:username, original.username)}.to raise_error ActiveRecord::RecordNotUnique
  end

  it "validates the uniqueness of email when present" do
    original = FactoryGirl.create(:user, :with_email)
    duplicate = FactoryGirl.build(:user, email: original.email)
    duplicate.valid?
    expect(duplicate.errors[:email]).to include "has already been taken"
  end

  it "doesn't fail on email uniqueness when empty" do
    original = FactoryGirl.create(:user)
    duplicate = FactoryGirl.build(:user)
    duplicate.valid?
    expect(duplicate.errors[:email]).to be_empty
  end

  it "has a unique index on email in the database" do
    original = FactoryGirl.create(:user, :with_email)
    duplicate = FactoryGirl.create(:user, :with_email)
    expect{duplicate.update_column(:email, original.email)}.to raise_error ActiveRecord::RecordNotUnique
  end
end
