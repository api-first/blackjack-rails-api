class CreateRanks < ActiveRecord::Migration
  def change
    create_table :ranks do |t|
      t.string :code, null: false
      t.string :name, null: false, index: true

      t.timestamps null: false
    end
    add_index :ranks, :code, unique: true
  end
end
