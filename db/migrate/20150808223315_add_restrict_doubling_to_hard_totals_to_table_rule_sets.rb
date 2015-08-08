class AddRestrictDoublingToHardTotalsToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :restrict_doubling_to_hard_totals, :text
  end
end
