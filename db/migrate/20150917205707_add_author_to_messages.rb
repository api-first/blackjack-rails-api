class AddAuthorToMessages < ActiveRecord::Migration
  def change
    add_reference :messages, :author, index: true, polymorphic: true
  end
end
