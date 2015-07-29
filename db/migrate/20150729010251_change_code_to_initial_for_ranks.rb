class ChangeCodeToInitialForRanks < ActiveRecord::Migration
  def change
    rename_column :ranks, :code, :initial
  end
end
