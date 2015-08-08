module V1
  class CardResource < BaseResource
    include StringPrimaryKey
    include ReadOnlyResource

    relationship :suit, to: :one

    relationship :rank, to: :one

    class << self
      def find_by_key(key, options = {})
        new(Card.find(key))
      end

      def find(filters, options = {})
        Card.all.map { |card| new(card) }
      end
    end

    def fetchable_fields
      super - [:created_at, :updated_at]
    end

  end
end
