class AddNoHoleCardToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :no_hole_card, :boolean, default: false, null: false
  end
end
