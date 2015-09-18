class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.belongs_to :channel, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
