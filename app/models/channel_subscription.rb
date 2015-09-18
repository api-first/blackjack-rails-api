class ChannelSubscription < ActiveRecord::Base
  belongs_to :channel

  belongs_to :subscriber, polymorphic: true

  validates :channel, presence: true

  validates :subscriber, presence: true

  validates :channel_id, uniqueness: { scope: [:subscriber_id, :subscriber_type], message: "has already been taken for the subscriber" }
end
