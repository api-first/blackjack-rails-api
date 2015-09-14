class AddTransactionToWagers < ActiveRecord::Migration
  def change
    add_reference :wagers, :transaction, index: true, foreign_key: true, null: false
  end
end
