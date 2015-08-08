class AddDoubleDownMinimumPercentageToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :double_down_minimum_percentage, :decimal, null: false, default: "1.0"
  end
end
