class AddNonControllingPlayerChoosesSplitHandToBetIfNotFollowingToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :non_controlling_player_chooses_split_hand_to_bet_if_not_following, :boolean, default: false, null: false
  end
end
