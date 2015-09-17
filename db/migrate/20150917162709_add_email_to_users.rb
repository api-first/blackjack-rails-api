class AddEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_index :users, :email, unique: true, where: "email IS NOT NULL"
  end
end
