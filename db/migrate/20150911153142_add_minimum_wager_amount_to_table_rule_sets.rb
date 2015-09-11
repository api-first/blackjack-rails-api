class AddMinimumWagerAmountToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :minimum_wager_amount, :integer, null: false
  end
end
