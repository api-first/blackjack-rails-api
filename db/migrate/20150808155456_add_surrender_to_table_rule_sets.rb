class AddSurrenderToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :surrender, :integer, null: false, default: 0
  end
end
