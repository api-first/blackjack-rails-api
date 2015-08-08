class AddInsurancePayOutToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :insurance_pay_out, :decimal
  end
end
