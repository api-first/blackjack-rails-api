RSpec.describe TablePlayerPositionPolicy do
  let! :record do
    FactoryGirl.create(:table_player_position)
  end

  subject do
    described_class.new user, record
  end

  context "when the record's player belongs to the user" do
    let! :user do
      record.player.user
    end

    it "can create the record" do
      expect(subject.create?).to eq true
    end
    it "can show the record" do
      expect(subject.show?).to eq true
    end
    it "can update the record" do
      expect(subject.update?).to eq true
    end
    it "can destroy the record" do
      expect(subject.destroy?).to eq true
    end
    it "has the record in scope" do
      expect(subject.scope).to include record
    end
  end

  context "when the record's player does not belong to the user" do
    let! :user do
      FactoryGirl.create(:user)
    end
    it "cannot create the record" do
      expect(subject.create?).to eq false
    end
    it "can show the record" do
      expect(subject.show?).to eq true
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
