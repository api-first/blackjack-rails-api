class AddDeckCountToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :deck_count, :integer, null: false
  end
end
