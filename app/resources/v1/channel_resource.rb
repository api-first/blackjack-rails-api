module V1
  class ChannelResource < BaseResource

    attribute :name

    attribute :description

    attribute :status

    has_many :messages

    class << self
      def creatable_fields(context)
        [
          :status,
          :name,
          :description,
        ]
      end

      alias_method :updatable_fields, :creatable_fields
    end

    def fetchable_fields
      super
    end

  end
end
