RSpec.describe TablePlayerPositionEventPolicy do

  subject do
    described_class.new(user, record)
  end

  let :record do
    FactoryGirl.create(:table_player_position_event)
  end

  context "when the user is a pit boss" do
    let :user do
      FactoryGirl.create(:user, pit_boss: true)
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

  context "when the player belongs to the user" do
    let :user do
      record.player.user
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

  context "when the player does not belong to the user" do
    let :user do
      FactoryGirl.create(:user)
    end
    it "cannot create the record" do
      expect(subject.create?).to eq false
    end
    it "cannot show the record" do
      expect(subject.show?).to eq false
    end
    it "cannot update the record" do
      expect(subject.update?).to eq false
    end
    it "cannot destroy the record" do
      expect(subject.destroy?).to eq false
    end
    it "does not have the record in scope" do
      expect(subject.scope).not_to include record
    end
  end

end
