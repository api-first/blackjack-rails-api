class AddDealerDrawsIfSoftStandAtToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :dealer_draws_if_soft_stand_at, :boolean, default: false, null: false
  end
end
