class Review < ApplicationRecord
  belongs_to :user
  has_many :friend_reviews
  has_many :review_tags
  has_many :tags, through: :review_tags
  validates :media, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 5000 }
end
