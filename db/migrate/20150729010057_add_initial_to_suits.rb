class AddInitialToSuits < ActiveRecord::Migration
  def change
    add_column :suits, :initial, :string, null: false
    add_index :suits, :initial, unique: true
  end
end
