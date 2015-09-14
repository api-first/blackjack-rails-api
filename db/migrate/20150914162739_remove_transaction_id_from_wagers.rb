class RemoveTransactionIdFromWagers < ActiveRecord::Migration
  def change
    remove_column :wagers, :transaction_id
  end
end
