class Card

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank, @suit = rank, suit
  end

  class << self
    def find(id)
      @card_by_id ||= {}
      cached = @card_by_id[id]
      return cached if cached

      @card_by_id[id] = all.find { |card| card.id == id }
    end

    def all
      @all ||= begin
        Rank.all.map do |rank|
          Suit.all.map do |suit|
            new(rank, suit)
          end
        end.flatten
      end
    end
  end

  def id
    rank.initial + suit.initial
  end

  def suit_id
    suit.try(:id)
  end

  def rank_id
    rank.try(:id)
  end

end
