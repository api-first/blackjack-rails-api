class TablePlayerPosition < ActiveRecord::Base
  include RankedModel

  belongs_to :table

  belongs_to :player

  validates :table, presence: true

  validates :player, presence: true

  validates :position, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: :maximum_position }

  validate :_fewer_than_maximum_players_at_position

  ranks :order, with_same: [:table_id, :position]

  def maximum_position
    return 1 unless table

    table.player_position_count
  end

  def maximum_players_at_position
    return 1 unless table

    table.maximum_players_per_position
  end

  def others_at_position_count
    return 0 unless table

    others_at_position.size
  end

  def others_at_position
    all_at_position.select do |table_player_position|
      table_player_position != self
    end
  end

  def all_at_position
    table.table_player_positions.select do |table_player_position|
      table_player_position.position == position
    end
  end

  def controlling?
    all_at_position.sort_by(&:order).first == self
  end

  def _fewer_than_maximum_players_at_position
    if others_at_position_count >= maximum_players_at_position
      errors.add :position, "already has the maximum number of players"
    end
  end
end
