class AddPlayerMustStandOnSoft21ToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :player_must_stand_on_soft_21, :boolean, default: true, null: false
  end
end
