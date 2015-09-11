class AddRoundInitialBettingWindowSecondsToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :round_initial_betting_window_seconds, :integer, null: false, default: 30
  end
end
