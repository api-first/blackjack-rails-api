module V1
  class UserResource < BaseResource

    attribute :username
    attribute :password

    class << self
      def creatable_fields(context)
        [
          :username,
          :password
        ]
      end

      alias_method :updatable_fields, :creatable_fields
    end

    def fetchable_fields
      super - [:password]
    end

  end
end
