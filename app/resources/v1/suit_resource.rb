module V1
  class SuitResource < BaseResource
    attribute :color

    class << self
      def creatable_fields(context = nil)
        []
      end
      alias_method :updatable_fields, :creatable_fields

      def verify_key(key, context = nil)
        key && String(key)
      end
    end

  end
end
