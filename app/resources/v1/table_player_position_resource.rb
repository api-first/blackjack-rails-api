module V1
  class TablePlayerPositionResource < BaseResource

    has_one :table

    has_one :player

    has_many :hands

    has_many :current_hands, class_name: "Hand"

    attribute :position

    class << self
      def creatable_fields(context)
        [
          :table,
          :player,
          :position
        ]
      end

      def updatable_fields(context)
        []
      end
    end

  end
end
