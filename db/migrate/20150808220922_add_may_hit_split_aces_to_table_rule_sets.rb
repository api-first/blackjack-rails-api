class AddMayHitSplitAcesToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :may_hit_split_aces, :boolean, null: false, default: false
  end
end
