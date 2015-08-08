class AddNameToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :name, :string
  end
end
