class Round < ActiveRecord::Base
  belongs_to :table

  has_many :hands

  validates :table, presence: true

  validates :initial_betting_closed_at, presence: true

  validates :active, uniqueness: { scope: [:table_id] }, if: :active

  before_validation :_set_initial_betting_closed_at, if: :new_record?

  after_commit :_create_hands, on: [:create]

  def _set_initial_betting_closed_at
    return unless new_record? && table && table.table_rule_set

    self.initial_betting_closed_at = Time.now + _initial_betting_window_seconds
  end

  def _initial_betting_window_seconds
    table.try(:table_rule_set).try(:round_initial_betting_window_seconds)
  end

  def _create_hands
    Round.transaction do
      # reload the table because the instance might not
      # have the table player positions in memory
      table.reload.table_player_positions.each do |table_player_position|
        hands.create!(position: table_player_position.position)
      end
    end
  end

  def total_wagers
    Wager.where(hand: hands).sum(:amount)
  end
end
