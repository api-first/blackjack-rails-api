RSpec.describe Suit do

  it "has a color enum with black as 0 and red as 1" do
    [:black, :red].each_with_index do |color, index|
      expect(described_class.colors[color]).to eq index
    end
  end

  it "can set and get the color" do
    subject.color = :red
    expect(subject.color).to eq "red"
  end

  it "can set and get the name" do
    subject.name = "spades"
    expect(subject.name).to eq "spades"
  end

  it "can get and set the initial" do
    subject.initial = "s"
    expect(subject.initial).to eq "s"
  end

  it "uses the name as the primary_key" do
    subject.id = "s"
    expect(subject.initial).to eq "s"
  end

  it "can find the suit using the name" do
    suit = FactoryGirl.create(:suit, initial: "s")
    expect(Suit.find("s")).to eq suit
  end

  it "seeds the four traditional suits as expected" do
    BlackjackRailsApi::Application.load_tasks
    Rake::Task["db:seed"].execute
    expect(Suit.count).to eq 4

    [
      ["s","spades","black"],
      ["c","clubs","black"],
      ["h","hearts","red"],
      ["d","diamonds","red"]
    ].each do |intitial, name, color|
      expect(Suit.find_by(name: name, color: Suit.colors[color])).not_to be_nil
    end
  end

end
