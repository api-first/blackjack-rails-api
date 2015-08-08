class AddStandardPayOutToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :standard_pay_out, :decimal, null: false
  end
end
