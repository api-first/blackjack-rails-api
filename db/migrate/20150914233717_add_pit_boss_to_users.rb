class AddPitBossToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pit_boss, :boolean, null: false, default: false
  end
end
