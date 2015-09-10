class RemoveControllingAttributeFromTablePlayerPositions < ActiveRecord::Migration
  def change
    remove_column :table_player_positions, :controlling
  end
end
