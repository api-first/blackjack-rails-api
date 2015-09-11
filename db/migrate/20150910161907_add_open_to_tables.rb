class AddOpenToTables < ActiveRecord::Migration
  def change
    add_column :tables, :open, :boolean, default: true, null: false
  end
end
