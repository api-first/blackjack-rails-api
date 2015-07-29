RSpec.describe Card do

  let :rank do
    FactoryGirl.build(:ace)
  end

  let :suit do
    FactoryGirl.build(:spades)
  end

  subject do
    described_class.new(rank, suit)
  end

  it "it initialized with a rank and a suit" do
    expect(subject.rank).to eq rank
    expect(subject.suit).to eq suit
  end

  it "has a suit_id method" do
    expect(subject.suit_id).to eq suit.id
  end

  it "has a rank_id method" do
    expect(subject.rank_id).to eq rank.id
  end

  it "has an id which concatenates the initial of the rank and the suit" do
    expect(subject.id).to eq "AS"
  end

  it "has a #all class method that returns all the cards" do
    expect(Card.all.size).to eq 52

    Rank.all.to_a.product(Suit.all.to_a).each do |rank, suit|
      expect(
        Card.all.find { |card| card.rank == rank && card.suit == suit }
      ).not_to be_nil
    end
  end

end
