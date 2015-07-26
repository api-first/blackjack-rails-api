class Suit < ActiveRecord::Base

  self.primary_key = "name"

  enum color: [:black, :red]

end
