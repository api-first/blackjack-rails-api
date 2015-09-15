RSpec.describe HandCardPolicy do
  let! :record do
    FactoryGirl.create(:hand_card)
  end

  subject do
    described_class.new user, record
  end

  context "with any user" do
    let! :user do
      FactoryGirl.create(:user)
    end

    it "can show the hand card" do
      expect(subject.show?).to eq true
    end

    it "cannot create the hand card" do
      expect(subject.create?).to eq false
    end

    it "cannot update the hand card" do
      expect(subject.update?).to eq false
    end

    it "has the hand card in scope" do
      expect(subject.scope).to include record
    end
  end
end
