class Review < ApplicationRecord
  belongs_to :user
  has_many :friend_reviews
end
