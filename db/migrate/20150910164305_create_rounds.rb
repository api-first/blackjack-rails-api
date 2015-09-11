class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.belongs_to :table, index: true, foreign_key: true, null: false
      t.datetime :betting_closed_at, null: false

      t.timestamps null: false
    end
  end
end
