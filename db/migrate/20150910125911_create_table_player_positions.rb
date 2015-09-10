class CreateTablePlayerPositions < ActiveRecord::Migration
  def change
    create_table :table_player_positions do |t|
      t.belongs_to :table, index: true, foreign_key: true, null: false
      t.integer :position, null: false
      t.boolean :controlling, default: true, null: false

      t.timestamps null: false
    end
  end
end
