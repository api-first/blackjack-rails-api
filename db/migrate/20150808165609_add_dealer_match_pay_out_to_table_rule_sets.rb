class AddDealerMatchPayOutToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :dealer_match_pay_out, :decimal
  end
end
