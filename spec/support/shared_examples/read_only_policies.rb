RSpec.shared_examples "read only policy" do
  subject do
    described_class.new(user, record)
  end

  let! :user do
    FactoryGirl.create(:user)
  end

  let! :record do
    described_class.model_class.all.sample
  end

  it "can be shown" do
    expect(subject.show?).to eq true
  end

  it "is in scope" do
    expect(subject.scope).to include record
  end

  it "cannot be created" do
    expect(subject.create?).to eq false
  end

  it "cannot be updated" do
    expect(subject.update?).to eq false
  end

  it "cannot be destroyed" do
    expect(subject.destroy?).to eq false
  end

end
