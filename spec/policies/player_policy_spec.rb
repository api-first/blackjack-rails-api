RSpec.describe PlayerPolicy do

  subject do
    described_class.new user, record
  end

  let! :record do
    FactoryGirl.create(:player)
  end

  context "when the player is the user's" do
    let :user do
      record.user
    end
    it "can create the player" do
      expect(subject.create?).to eq true
    end
    it "can update the player" do
      expect(subject.update?).to eq true
    end
    it "can show the player" do
      expect(subject.show?).to eq true
    end
    it "can destroy the player" do
      expect(subject.destroy?).to eq true
    end
    it "has the player in scope" do
      expect(subject.scope).to include record
    end
  end

  context "when the player is not the user's" do
    let! :user do
      FactoryGirl.create(:user)
    end
    it "cannot create the player" do
      expect(subject.create?).to eq false
    end
    it "cannot update the player" do
      expect(subject.update?).to eq false
    end
    it "can show the player" do
      expect(subject.show?).to eq true
    end
    it "cannot destroy the player" do
      expect(subject.destroy?).to eq false
    end
    it "has the player in scope" do
      expect(subject.scope).to include record
    end
  end
end
