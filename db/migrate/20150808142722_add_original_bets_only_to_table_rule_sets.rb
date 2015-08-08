class AddOriginalBetsOnlyToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :original_bets_only, :boolean
  end
end
