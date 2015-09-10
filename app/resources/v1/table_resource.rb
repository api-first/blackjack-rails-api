module V1
  class TableResource < BaseResource

    has_one :table_rule_set

    class << self
      def creatable_fields(context)
        [
          :table_rule_set
        ]
      end

      alias_method :updatable_fields, :creatable_fields
    end

  end
end
