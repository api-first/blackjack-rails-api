RSpec.describe TablePolicy do

  subject do
    described_class.new(user, record)
  end

  let :record do
    FactoryGirl.create(:table)
  end

  context "when the user is a pit boss" do

    let :user do
      FactoryGirl.create(:user, pit_boss: true)
    end

    it "can be created" do
      expect(subject.create?).to eq true
    end

    it "can be shown" do
      expect(subject.show?).to eq true
    end

    it "can be updated" do
      expect(subject.update?).to eq true
    end

    it "can be destroyed" do
      expect(subject.destroy?).to eq true
    end

    it "is in scope" do
      expect(subject.scope).to include record
    end
  end

  context "when the user is not a pit boss" do

    let :user do
      FactoryGirl.create(:user, pit_boss: false)
    end

    it "cannot be created" do
      expect(subject.create?).to eq false
    end

    it "can be shown" do
      expect(subject.show?).to eq true
    end

    it "cannot be updated" do
      expect(subject.update?).to eq false
    end

    it "cannot be destroyed" do
      expect(subject.destroy?).to eq false
    end

    it "is in scope" do
      expect(subject.scope).to include record
    end
  end

end
