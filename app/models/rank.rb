class Rank < ActiveRecord::Base
  self.primary_key = :initial

  def numbered?
    initial.to_i > 0
  end

  def face?
    initial.to_i == 0
  end
end
