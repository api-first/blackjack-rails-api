class AddOrderToTablePlayerPositions < ActiveRecord::Migration
  def change
    add_column :table_player_positions, :order, :integer, null: false
  end
end
