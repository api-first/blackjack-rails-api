class AddUniqueIndexToNameForTableRuleSets < ActiveRecord::Migration
  def change
    add_index :table_rule_sets, :name, unique: true
  end
end
