class AddMinimumPlayersPerRoundToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :minimum_players_per_round, :integer, null: false, default: 1
  end
end
