RSpec.describe Round do
  it "belongs to a table" do
    expect(subject.build_table).to be_a Table
  end

  it "validates the presence of table" do
    subject.table = nil
    subject.valid?
    expect(subject.errors[:table]).to include "can't be blank"
  end

  it "validates the presence of initial_betting_closed_at" do
    allow(subject).to receive(:initial_betting_closed_at).and_return(nil)
    subject.valid?
    expect(subject.errors[:initial_betting_closed_at]).to include "can't be blank"
  end

  it "initializes as active" do
    expect(subject).to be_active
  end

  it "can only have one active round for a table at one time" do
    table = FactoryGirl.create(:table)
    FactoryGirl.create(:round, active: true, table: table)
    subject = FactoryGirl.build(:round, active: true, table: table)
    subject.valid?
    expect(subject.errors[:active]).to include "has already been taken"
  end
end
