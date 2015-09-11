RSpec.describe HandCard do
  it "belongs to a hand" do
    expect(subject.build_hand).to be_a Hand
  end

  it "belongs to a card" do
    subject.card_id = "AS"
    expect(subject.card).to eq Card.find("AS")
  end

  it "validates the presence of hand" do
    subject.hand = nil
    subject.valid?
    expect(subject.errors[:hand]).to include "can't be blank"
  end

  it "validates the presence of card_id" do
    subject.card_id = nil
    subject.valid?
    expect(subject.errors[:card_id]).to include "can't be blank"
  end

  it "validates that the card_id is one of the valid potential card ids" do
    subject.card_id = "55"
    subject.valid?
    expect(subject.errors[:card_id]).to include "is not included in the list"
  end

  it "does not contain an error if the card_id is in the list" do
    subject.card_id = "AS"
    subject.valid?
    expect(subject.errors[:card_id]).to be_empty
  end

  it "puts the hand_cards in order" do
    hand = FactoryGirl.create(:hand)
    hand_cards = 2.times.map { FactoryGirl.create(:hand_card, hand: hand) }
    expect(hand.hand_cards.rank(:order).first).to eq hand_cards.first
    expect(hand.hand_cards.rank(:order).last).to eq hand_cards.last
  end
end
