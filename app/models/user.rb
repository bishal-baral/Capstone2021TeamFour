class User < ApplicationRecord
  has_many :reviews
  has_many :friends
  has_many :friend_reviews
end
