class User < ActiveRecord::Base
  has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :email,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
            unless: -> { email.blank? }
  validates :email, uniqueness: true, unless: -> { email.blank? }

  has_many :players
end
