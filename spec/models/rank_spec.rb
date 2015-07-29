RSpec.describe Rank do

  it "has a valid factory for each pip rank" do
    (2..10).each do |n|
      expect(FactoryGirl.build(n)).to be_valid
    end
  end

  it "can set and get the initial" do
    subject.initial = "1"
    expect(subject.initial).to eq "1"
  end

  it "can set and get the name" do
    subject.name = "Ace"
    expect(subject.name).to eq "Ace"
  end

  it "uses the initial as the primary_key" do
    expect(described_class.primary_key).to eq "initial"
  end

  it "seeds all the ranks" do
    BlackjackRailsApi::Application.load_tasks
    Rake::Task["db:seed"].execute

    expected_initials = ["2","3","4","5","6","7","8","9","10","J","Q","K","A"]
    expect(Rank.count).to eq expected_initials.count
    actual_initials = Rank.pluck(:initial)
    expected_initials.each do |initial|
      expect(actual_initials).to include initial
    end
  end

  it "knows that numbered cards are numbered but not face" do
    (2..10).each do |initial|
      subject = described_class.new(initial: initial)
      expect(subject.numbered?).to eq true
      expect(subject.face?).to eq false
    end
  end

  it "knows that face cards are face but not numbered" do
    ["J","Q","K","A"].each do |initial|
      subject = described_class.new(initial: initial)
      expect(subject.numbered?).to eq false
      expect(subject.face?).to eq true
    end
  end

end
