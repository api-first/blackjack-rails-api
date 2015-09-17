class AddNameToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :name, :string, null: false, default: "Unnamed"
  end
end
