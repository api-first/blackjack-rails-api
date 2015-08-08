class AddInsuranceAvailableToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :insurance_available, :boolean, default: true, null: false
  end
end
