class BooleanValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless [true, false].any? { |boolean| value == boolean }
      record.errors[attribute] << (options[:message] || "must be true or false")
    end
  end
end
