RSpec.describe Rank do

  it "has a valid factory for each pip rank" do
    (2..10).each do |n|
      expect(FactoryGirl.build(n)).to be_valid
    end
  end

  it "can set and get the initial" do
    subject.initial = "2"
    expect(subject.initial).to eq "2"
  end

  it "can set and get the name" do
    subject.name = "Ace"
    expect(subject.name).to eq "Ace"
  end

  it "uses the initial as the primary_key" do
    expect(described_class.primary_key).to eq "initial"
  end

  it "seeds all the ranks" do
    expected_initials_and_values = {
      "2" => [2],
      "3" => [3],
      "4" => [4],
      "5" => [5],
      "6" => [6],
      "7" => [7],
      "8" => [8],
      "9" => [9],
      "10" => [10],
      "J" => [10],
      "Q" => [10],
      "K" => [10],
      "A" => [1,11]
    }

    expect(Rank.count).to eq expected_initials_and_values.size
    expected_initials_and_values.each do |initial, values|
      rank = Rank.find_by(initial: initial)
      expect(rank).not_to be_nil
      expect(rank.values).to eq values
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

  it "has a values attribute" do
    expect(subject.values).to eq []
  end

  it "validates that values is not empty" do
    subject.values = []
    subject.valid?
    expect(subject.errors[:values]).not_to be_empty
  end

  it "has an order attribute that is required" do
    subject.order = nil
    subject.valid?
    expect(subject.errors[:order]).not_to be_empty
  end

  it "sorts the ranks by order by default" do
    expect(Rank.pluck(:initial)).to eq ["2","3","4","5","6","7","8","9","10","J","Q","K","A"]
  end

end
