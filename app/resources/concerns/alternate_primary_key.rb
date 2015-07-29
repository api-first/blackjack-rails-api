# include in resources that have an alternate primary key

module AlternatePrimaryKey
  extend ActiveSupport::Concern

  class_methods do
    def verify_key(key, context = nil)
      key && String(key)
    end
  end
end
