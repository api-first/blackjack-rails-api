class AddDoubleDownMaximumPercentageToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :double_down_maximum_percentage, :decimal, null: false, default: "1.0"
  end
end
