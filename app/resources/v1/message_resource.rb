module V1
  class MessageResource < BaseResource

    attribute :body

    has_one :channel

    has_one :author, polymorphic: true

    class << self
      def creatable_fields(context)
        [
          :channel,
          :author,
          :body
        ]
      end

      alias_method :updatable_fields, :creatable_fields
    end

    def fetchable_fields
      super
    end

  end
end
