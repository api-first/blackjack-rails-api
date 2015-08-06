class AddOrderToRanks < ActiveRecord::Migration
  def change
    add_column :ranks, :order, :integer, null: false
    add_index :ranks, :order, unique: true
  end
end
