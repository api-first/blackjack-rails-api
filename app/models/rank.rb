class Rank < ActiveRecord::Base

  self.primary_key = :initial

  serialize :values, JSON

  validate :_values_is_not_empty

  validates :order, presence: true, uniqueness: true

  default_scope { order(order: :asc) }

  def numbered?
    initial.to_i > 0
  end

  def face?
    initial.to_i == 0
  end

  def _values_is_not_empty
    if values.empty?
      errors.add :values, "must not be empty"
    end
  end

end
