class AddMaximumBetsPerPlayerToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :maximum_bets_per_player, :integer, null: false
  end
end
