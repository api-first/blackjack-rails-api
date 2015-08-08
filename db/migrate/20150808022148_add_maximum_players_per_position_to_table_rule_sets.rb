class AddMaximumPlayersPerPositionToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :maximum_players_per_position, :integer, null: false
  end
end
