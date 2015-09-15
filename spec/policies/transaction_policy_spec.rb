RSpec.describe TransactionPolicy do
  let! :record do
    FactoryGirl.create(:transaction)
  end

  subject do
    described_class.new user, record
  end

  context "when the user is a pit boss" do
    let! :user do
      FactoryGirl.create(:user, pit_boss: true)
    end

    it "cannot create the transaction" do
      expect(subject.create?).to eq false
    end
    it "can show the transaction" do
      expect(subject.show?).to eq true
    end
    it "cannot update the transaction" do
      expect(subject.create?).to eq false
    end
    it "cannot destroy the transaction" do
      expect(subject.destroy?).to eq false
    end
    it "has the transaction in scope" do
      expect(subject.scope).to include record
    end
  end

  context "when the user is directly related to the transaction" do
    let! :user do
      record.player.user
    end
    it "cannot create the transaction" do
      expect(subject.create?).to eq false
    end
    it "can show the transaction" do
      expect(subject.show?).to eq true
    end
    it "cannot update the transaction" do
      expect(subject.create?).to eq false
    end
    it "cannot destroy the transaction" do
      expect(subject.destroy?).to eq false
    end
    it "has the transaction in scope" do
      expect(subject.scope).to include record
    end
  end

  context "when the user is not directly related to the transaction" do
    let! :user do
      FactoryGirl.create(:user)
    end
    it "cannot create the transaction" do
      expect(subject.create?).to eq false
    end
    it "can show the transaction" do
      expect(subject.show?).to eq false
    end
    it "cannot update the transaction" do
      expect(subject.create?).to eq false
    end
    it "cannot destroy the transaction" do
      expect(subject.destroy?).to eq false
    end
    it "has the transaction in scope" do
      expect(subject.scope).not_to include record
    end
  end
end
