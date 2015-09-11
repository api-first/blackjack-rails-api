class AddKindToWagers < ActiveRecord::Migration
  def change
    add_column :wagers, :kind, :integer, null: false, default: 0
  end
end
