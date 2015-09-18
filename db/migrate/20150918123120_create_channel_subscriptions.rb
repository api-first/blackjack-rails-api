class CreateChannelSubscriptions < ActiveRecord::Migration
  def change
    create_table :channel_subscriptions do |t|
      t.belongs_to :channel, index: true, foreign_key: true
      t.belongs_to :subscriber, polymorphic: true

      t.timestamps null: false
    end
    add_index :channel_subscriptions, [:subscriber_id, :subscriber_type], name: "idx_channel_sub_sub"
    add_index :channel_subscriptions, [:subscriber_id, :subscriber_type, :channel_id], unique: true, name: "idx_channel_unique_c_s"
  end
end
