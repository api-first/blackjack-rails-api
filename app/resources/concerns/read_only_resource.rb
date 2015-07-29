module ReadOnlyResource
  extend ActiveSupport::Concern

  class_methods do
    def creatable_fields(context = nil)
      []
    end
    alias_method :updatable_fields, :creatable_fields
  end
end
