class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :kind, null: false
      t.decimal :amount, null: false
      t.belongs_to :player, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
