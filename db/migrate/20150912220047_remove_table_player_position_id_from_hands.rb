class RemoveTablePlayerPositionIdFromHands < ActiveRecord::Migration
  def change
    remove_column :hands, :table_player_position_id
  end
end
