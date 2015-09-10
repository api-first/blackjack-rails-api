class AddPlayerToTablePlayerPositions < ActiveRecord::Migration
  def change
    add_reference :table_player_positions, :player, index: true, foreign_key: true, null: false
  end
end
