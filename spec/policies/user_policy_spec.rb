RSpec.describe UserPolicy do
  subject do
    UserPolicy.new(user, record)
  end

  context "when the user is the same as the record" do
    let :user do
      FactoryGirl.create(:user)
    end

    let :record do
      user
    end

    it "can be updated" do
      expect(subject.update?).to eq true
    end

    it "can be shown" do
      expect(subject.show?).to eq true
    end

    it "cannot be destroyed" do
      expect(subject.destroy?).to eq false
    end

    it "has the record in scope" do
      expect(subject.scope).to include record
    end
  end

  context "when the user is a pit_boss" do
    let :user do
      FactoryGirl.create(:user, pit_boss: true, username: "pitboss")
    end

    let :record do
      FactoryGirl.create(:user, username: "gambler")
    end

    it "can be shown" do
      expect(subject.show?).to eq true
    end

    it "can be updated" do
      expect(subject.update?).to eq true
    end

    it "cannot be destroyed" do
      expect(subject.destroy?).to eq false
    end

    it "has the record in scope" do
      expect(subject.scope).to include record
    end
  end

  context "when the user is not a pit boss and isn't the record" do
    let :record do
      FactoryGirl.create(:user, username: "gambler")
    end

    let :user do
      FactoryGirl.create(:user, username: "bossman", pit_boss: false)
    end

    it "cannot be shown" do
      expect(subject.show?).to eq false
    end

    it "cannot be updated" do
      expect(subject.update?).to eq false
    end

    it "cannot be destroyed" do
      expect(subject.destroy?).to eq false
    end

    it "does not have the record in scope" do
      expect(subject.scope).not_to include record
    end
  end
end
