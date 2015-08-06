RSpec.describe Deck do

  it "has cards, one of each suit and rank" do
    expected_card_count = Suit.count * Rank.count
    expect(subject.cards.size).to eq expected_card_count
  end

  it "can shuffle the deck and put the cards in a different order" do
    card_ids = subject.cards.map(&:id)
    subject.shuffle
    shuffled_card_ids = subject.cards.map(&:id)
    expect(card_ids).not_to eq shuffled_card_ids
  end

end
