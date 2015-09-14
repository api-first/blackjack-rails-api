module V1
  class WagerResource < BaseResource

    has_one :hand

    has_one :player

    attribute :kind

    attribute :amount

    class << self
      def creatable_fields(context)
        [:hand, :player, :kind, :amount]
      end

      def updatable_fields(context)
        []
      end
    end

  end
end
