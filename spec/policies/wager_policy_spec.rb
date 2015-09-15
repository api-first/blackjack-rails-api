RSpec.describe WagerPolicy do
  let :record do
    FactoryGirl.create(:wager)
  end

  subject do
    described_class.new user, record
  end

  context "when the user is unrelated to the wager" do
    let! :user do
      FactoryGirl.create(:user)
    end
    it "can show the record" do
      expect(subject.show?).to eq true
    end
    it "cannot create the record" do
      expect(subject.create?).to eq false
    end
    it "cannot update the record" do
      expect(subject.update?).to eq false
    end
    it "cannot destroy the record" do
      expect(subject.destroy?).to eq false
    end
    it "has the record in scope" do
      expect(subject.scope).to include record
    end
  end

  context "when the user is related to the wager" do
    let! :user do
      record.player.user
    end
    it "can show the record" do
      expect(subject.show?).to eq true
    end
    it "cannot create the record" do
      expect(subject.create?).to eq true
    end
    it "cannot update the record" do
      expect(subject.update?).to eq false
    end
    it "cannot destroy the record" do
      expect(subject.destroy?).to eq false
    end
    it "has the record in scope" do
      expect(subject.scope).to include record
    end
  end
end
