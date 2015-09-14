class AddPositionToHands < ActiveRecord::Migration
  def change
    add_column :hands, :position, :integer, null: false
  end
end
