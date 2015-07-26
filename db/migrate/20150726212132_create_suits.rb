class CreateSuits < ActiveRecord::Migration
  def change
    create_table :suits, id: false do |t|
      t.string :name, null: false
      t.integer :color, null: false, index: true

      t.timestamps null: false
    end
    add_index :suits, :name, unique: true
  end
end
