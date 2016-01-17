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

  def current_round_id
    current_round.try(:id)
  end

  def player_joined(table_player_position)
    if current_round
      if Time.now < current_round.initial_betting_closed_at
        current_round.hands.find_or_create_by!(position: table_player_position.position)
      end
    else
      if table_player_positions.count >= table_rule_set.minimum_players_per_round
        rounds.create!(active: true)
      end
    end
  end

  def positions
    return [] unless table_rule_set

    @positions ||= (1..table_rule_set.player_position_count).to_a
  end

  def _destroy_table_player_positions
    return if open?

    table_player_positions.destroy_all
  end
end
