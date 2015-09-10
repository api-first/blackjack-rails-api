class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.belongs_to :table_rule_set, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
