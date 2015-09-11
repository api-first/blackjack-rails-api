class Table < ActiveRecord::Base
  belongs_to :table_rule_set

  has_many :table_player_positions

  has_many :rounds

  has_one :current_round, -> { where(active: true) }, class_name: "Round"

  validates :table_rule_set, presence: true

  delegate :player_position_count, to: :table_rule_set

  delegate :maximum_players_per_position, to: :table_rule_set

  after_commit :_destroy_table_player_positions, if: :closed?

  def closed?
    !open?
  end

  def _destroy_table_player_positions
    return if open?

    table_player_positions.destroy_all
  end
end
