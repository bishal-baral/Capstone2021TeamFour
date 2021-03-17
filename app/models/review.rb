class Review < ApplicationRecord
  belongs_to :user
  has_many :friend_reviews
  validates :media, presence: true, length: { maximum: 5000 }
  validates :recommended, presence: true
end
