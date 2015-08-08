module V1
  class BaseResource < JSONAPI::Resource
    abstract

    attribute :created_at
    attribute :updated_at

    class << self
      def creatable_fields(context)
        super - [:id, :created_at, :updated_at]
      end
    end

  end
end
