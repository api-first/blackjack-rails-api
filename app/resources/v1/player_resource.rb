module V1
  class PlayerResource < BaseResource

    has_one :user

    class << self
      def creatable_fields(context)
        [
          :user,
        ]
      end

      alias_method :updatable_fields, :creatable_fields
    end

    def fetchable_fields
      super
    end

  end
end
