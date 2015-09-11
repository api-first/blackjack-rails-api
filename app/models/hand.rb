class Hand < ActiveRecord::Base
  belongs_to :round

  belongs_to :table_player_position

  has_many :wagers

  has_many :hand_cards
end
