class Message < ActiveRecord::Base
  belongs_to :channel

  belongs_to :author, polymorphic: true

  validates :channel, presence: true

  validates :body, presence: true
end
