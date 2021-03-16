class User < ApplicationRecord
  has_many :reviews
  has_many :friends
  has_many :friend_reviews

  
  before_save { self.email = email.downcase }
  #Email validations
  validates :username, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  # To hash the password.
  validates :password, presence: true, length: {minimum: 6}
  has_secure_password
end
