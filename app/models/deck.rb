class Deck

  attr_reader :cards

  def initialize
    @cards = _build_cards
  end

  def shuffle
    @cards = @cards.shuffle
  end

  def _build_cards
    Rank.all.product(Suit.all).collect do |rank, suit|
      Card.new(rank, suit)
    end
  end

end
