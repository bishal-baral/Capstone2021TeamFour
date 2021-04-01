class Friendship < ApplicationRecord

  # Will link to the foreign keys in users table
  belongs_to :sent_to, class_name: 'User', foreign_key: 'sent_to_id'
  belongs_to :sent_by, class_name: 'User', foreign_key: 'sent_by_id'
  
  #Define a scope here to access the friends easily
  scope :friends, -> { where('status =?', true) }
  scope :not_friends, -> { where('status =?', false) }

  validate :users_exist, :user_friend_not_same, :duplicate_friendship

  def user_friend_not_same
    if sent_to_id == sent_by_id
      errors.add(:sent_by_id, "user cannot friend themself")
    end
  end

  def users_exist
    if User.where(id: sent_to_id).count == 0
      errors.add(:sent_to_id, "sendee has to exist")
    end

    if User.where(id: sent_by_id).count == 0
      errors.add(:sent_by_id, "sender has to exist")
    end
  end

  def duplicate_friendship
    if Friendship.where(sent_by_id: :sent_to_id, 
                        sent_to_id: :sent_by_id).count > 0
      errors.add(:sent_by_id, "friendship already exists")
    end
  end


end
