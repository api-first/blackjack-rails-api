class AddNameAndDescriptionToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :name, :string
    add_column :channels, :description, :string
  end
end
