class RenameBettingClosedAtToInitialBettingClosedAtForRounds < ActiveRecord::Migration
  def change
    rename_column :rounds, :betting_closed_at, :initial_betting_closed_at
  end
end
