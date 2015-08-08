class AddBlackjackPayOutToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :blackjack_pay_out, :decimal, null: false
  end
end
