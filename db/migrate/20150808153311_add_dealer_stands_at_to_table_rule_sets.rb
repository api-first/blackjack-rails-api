class AddDealerStandsAtToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :dealer_stands_at, :integer, default: 17, null: false
  end
end
