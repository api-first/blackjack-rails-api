class AddStatusToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :status, :integer, default: 0
  end
end
