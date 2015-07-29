# include in resources that have an string primary key

module StringPrimaryKey
  extend ActiveSupport::Concern

  class_methods do
    def verify_key(key, context = nil)
      key && String(key)
    end
  end
end
