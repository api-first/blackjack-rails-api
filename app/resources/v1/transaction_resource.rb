module V1
  class TransactionResource < BaseResource

    attribute :kind

    attribute :amount

    has_one :player

    has_one :action, polymorphic: true

    class << self
      def creatable_fields(context)
        []
      end

      def updatable_fields(context)
        []
      end
    end

  end
end
