module V1
  class BaseResource < JSONAPI::Resource
    abstract

    class << self
      def creatable_fields(context)
        super - [:id, :created_at, :updated_at]
      end
    end

  end
end
