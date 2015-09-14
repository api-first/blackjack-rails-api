module V1
  class RoundResource < BaseResource

    has_one :table

    attribute :initial_betting_closed_at

    attribute :active

    class << self
      def creatable_fields(context)
        []
      end
      alias_method :updatable_fields, :creatable_fields
    end

  end
end
