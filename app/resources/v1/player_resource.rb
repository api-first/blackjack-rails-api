module V1
  class PlayerResource < BaseResource

    attribute :name

    has_one :user

    filter :name

    class << self
      def creatable_fields(context)
        [
          :user,
          :name
        ]
      end

      alias_method :updatable_fields, :creatable_fields

      def apply_filter(records, filter, value, options)
        super
        case filter
        when :name
          records.where("players.name ILIKE ?", value)
        else super
        end
      end
    end

    def fetchable_fields
      super
    end

  end
end
