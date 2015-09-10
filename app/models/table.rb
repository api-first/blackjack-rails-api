class Table < ActiveRecord::Base
  belongs_to :table_rule_set

  has_many :table_player_positions

  validates :table_rule_set, presence: true

  delegate :player_position_count, to: :table_rule_set

  delegate :maximum_players_per_position, to: :table_rule_set
end
