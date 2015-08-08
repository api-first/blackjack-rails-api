class CreateTableRuleSets < ActiveRecord::Migration
  def change
    create_table :table_rule_sets do |t|

      t.timestamps null: false
    end
  end
end
