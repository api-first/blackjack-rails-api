class CreateTablePlayerPositionEvents < ActiveRecord::Migration
  def change
    create_table :table_player_position_events do |t|
      t.belongs_to :table, index: true, foreign_key: true, null: false
      t.belongs_to :player, index: true, foreign_key: true, null: false
      t.integer :position, null: false
      t.integer :event, null: false

      t.timestamps null: false
    end
  end
end
