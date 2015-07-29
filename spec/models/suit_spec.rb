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
    subject.initial = "S"
    expect(subject.initial).to eq "S"
  end

  it "uses the name as the primary_key" do
    subject.id = "S"
    expect(subject.initial).to eq "S"
  end

  it "can find the suit using the name" do
    expect(Suit.find("S")).not_to be_nil
  end

  it "seeds the four traditional suits as expected" do
    [
      ["S","spades","black"],
      ["C","clubs","black"],
      ["H","hearts","red"],
      ["D","diamonds","red"]
    ].each do |intitial, name, color|
      expect(Suit.find_by(name: name, color: Suit.colors[color])).not_to be_nil
    end
  end

end
