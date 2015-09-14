class Transaction < ActiveRecord::Base
  belongs_to :player

  validates :player, presence: true
end
