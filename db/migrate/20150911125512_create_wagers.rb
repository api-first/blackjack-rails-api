class CreateWagers < ActiveRecord::Migration
  def change
    create_table :wagers do |t|
      t.integer :amount
      t.belongs_to :hand, index: true, foreign_key: true, null: false
      t.belongs_to :player, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
