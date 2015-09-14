class ChangeAmountToDecimalForWagers < ActiveRecord::Migration
  def change
    change_column :wagers, :amount, :decimal
  end
end
