class AddMaximumDoubleCountPerHandToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :maximum_double_count_per_hand, :integer
  end
end
