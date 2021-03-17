class Friend < ApplicationRecord
  belongs_to :user
  validates :friend_id, presence: false
  validate :friend_exists, :user_friend_not_same


  def user_friend_not_same
    if user_id == friend_id
      errors.add(:friend_id, "friend can't be the same as user")
    end
  end

  def friend_exists
    if User.where(id: friend_id).count == 0
      errors.add(:friend_id, "friend has to exist")
    end
  end
end
