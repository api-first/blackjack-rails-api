class User < ActiveRecord::Base
  has_secure_password

  validates :username, presence: true

  validates :birth_date, presence: true

  has_many :players
end
