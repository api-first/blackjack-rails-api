class AddDealerMatchAvailableToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :dealer_match_available, :boolean, default: true, null: false
  end
end
