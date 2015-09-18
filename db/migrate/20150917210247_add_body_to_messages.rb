class AddBodyToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :body, :text, null: false
  end
end
