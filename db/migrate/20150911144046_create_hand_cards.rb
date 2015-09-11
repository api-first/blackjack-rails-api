class CreateHandCards < ActiveRecord::Migration
  def change
    create_table :hand_cards do |t|
      t.belongs_to :hand, index: true, foreign_key: true, null: false
      t.string :card_id, index: true, null: false
      t.integer :order, null: false
      t.boolean :face_up, null: false, default: true

      t.timestamps null: false
    end
  end
end
