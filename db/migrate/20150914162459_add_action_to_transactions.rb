class AddActionToTransactions < ActiveRecord::Migration
  def change
    add_reference :transactions, :action, index: true, polymorphic: true
  end
end
