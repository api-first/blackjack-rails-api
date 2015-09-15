RSpec.describe HandPolicy do
  subject do
    described_class.new user, record
  end

  let! :record do
    FactoryGirl.create(:hand)
  end

  context "any user" do
    let! :user do
      FactoryGirl.create(:user)
    end

    it "cannot create the hand" do
      expect(subject.create?).to eq false
    end

    it "can show the hand" do
      expect(subject.show?).to eq true
    end

    it "cannot update the hand" do
      expect(subject.update?).to eq false
    end

    it "cannot destroy the hand" do
      expect(subject.destroy?).to eq false
    end

    it "has the hand in scope" do
      expect(subject.scope).to include record
    end
  end

end
