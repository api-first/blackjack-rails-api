class AddValuesToRanks < ActiveRecord::Migration
  def change
    add_column :ranks, :values, :text, default: "[]"
  end
end
