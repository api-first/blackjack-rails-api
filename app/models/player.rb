class Player < ActiveRecord::Base

  belongs_to :user

  has_many :table_player_positions

  has_many :wagers

  validates :user, presence: true

end
