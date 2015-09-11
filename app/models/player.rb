class Player < ActiveRecord::Base

  has_many :table_player_positions

  has_many :wagers

end
