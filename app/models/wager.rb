class Wager < ActiveRecord::Base
  belongs_to :hand

  belongs_to :player

  validates :hand, presence: true

  validates :player, presence: true
end
