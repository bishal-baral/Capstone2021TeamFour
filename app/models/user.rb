class User < ApplicationRecord
  has_one_attached :avatar

  # sets the 'sent_by_id' in Friendship schema
  # inverse of 'sent_by' in Friendship model
  has_many :friend_sent, class_name: 'Friendship',
                         foreign_key: 'sent_by_id',
                         inverse_of: 'sent_by',
                         dependent: :destroy

  has_many :friend_request, class_name: 'Friendship',
                            foreign_key: 'sent_to_id',
                            inverse_of: 'sent_to',
                            dependent: :destroy

  has_many :friends, -> { merge(Friendship.friends) },
                      through: :friend_sent, source: :sent_to

  has_many :pending_requests, -> { merge(Friendship.not_friends) },
                              through: :friend_sent, source: :sent_to

  has_many :received_requests, -> { merge(Friendship.not_friends) },
                      through: :friend_request, source: :sent_by
                    

  has_many :friend_reviews
  has_many :reviews
  has_many :invitees
  
  before_save { self.email = email.downcase }
  #Email validations
  validates :username, presence: true, length: { maximum: 20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :code, presence: true, length: { is: 4 }

  # To hash the password.
  has_secure_password
end
