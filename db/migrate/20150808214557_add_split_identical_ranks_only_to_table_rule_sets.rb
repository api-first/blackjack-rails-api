class AddSplitIdenticalRanksOnlyToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :split_identical_ranks_only, :boolean, default: false, null: false
  end
end
