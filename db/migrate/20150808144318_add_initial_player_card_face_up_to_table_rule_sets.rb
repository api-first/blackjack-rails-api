class AddInitialPlayerCardFaceUpToTableRuleSets < ActiveRecord::Migration
  def change
    add_column :table_rule_sets, :initial_player_card_face_up, :boolean, default: true, null: false
  end
end
