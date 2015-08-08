class AddDealerWinsTiesToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :dealer_wins_ties, :boolean, default: false, null: false
  end
end
