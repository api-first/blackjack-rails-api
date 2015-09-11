class CreateHands < ActiveRecord::Migration
  def change
    create_table :hands do |t|
      t.belongs_to :round, index: true, foreign_key: true, null: false
      t.belongs_to :table_player_position, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
