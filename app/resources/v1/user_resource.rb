module V1
  class UserResource < BaseResource

    attribute :username
    attribute :password

    class << self
      def creatable_fields(context)
        fields = [:username, :password]
        if context && context[:current_user] && context[:current_user].pit_boss?
          fields += [:pit_boss]
        end
        fields
      end

      alias_method :updatable_fields, :creatable_fields
    end

    def fetchable_fields
      super - [:password]
    end

  end
end
