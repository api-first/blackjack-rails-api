class Round < ActiveRecord::Base
  belongs_to :table

  validates :table, presence: true

  validates :initial_betting_closed_at, presence: true

  validates :active, uniqueness: { scope: [:table_id] }, if: :active
end
