class AddUserToPlayers < ActiveRecord::Migration
  def change
    add_reference :players, :user, index: true, foreign_key: true, null: false
  end
end
