class Suit < ActiveRecord::Base

  self.primary_key = :initial

  enum color: [:black, :red]

end
