module V1
  class ChannelSubscriptionResource < BaseResource

    has_one :channel

    has_one :subscriber, polymorphic: true

    class << self
      def creatable_fields(context)
        [
          :channel,
          :subscriber
        ]
      end

      def updatable_fields(context)
        []
      end
    end

    def fetchable_fields
      super
    end

  end
end
