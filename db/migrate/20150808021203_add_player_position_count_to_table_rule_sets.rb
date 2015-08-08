class AddPlayerPositionCountToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :player_position_count, :integer, null: false
  end
end
