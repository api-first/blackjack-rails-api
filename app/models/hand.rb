class Hand < ActiveRecord::Base
  belongs_to :round

  has_many :wagers

  has_many :hand_cards

  validates :position, presence: true, inclusion: { in: :_table_positions }

  def _table_positions
    return [] unless round && round.table

    round.table.positions
  end
end
