module V1
  class HandResource < BaseResource

    has_one :round

    attribute :position

    class << self
      def creatable_fields(context)
        []
      end
      alias_method :updatable_fields, :creatable_fields
    end

  end
end
