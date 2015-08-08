class AddSurrenderPercentageToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :surrender_percentage, :decimal
  end
end
