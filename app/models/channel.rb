class Channel < ActiveRecord::Base
  has_many :messages

  enum status: [:open, :closed]
end
