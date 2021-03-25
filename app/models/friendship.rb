class Friendship < ApplicationRecord

  # Will link to the foreign keys in users table
  belongs_to :sent_to, class_name: 'User', foreign_key: 'sent_to_id'
  belongs_to :sent_by, class_name: 'User', foreign_key: 'sent_by_id'
  
  #Define a scope here to access the friends easily
  scope :friends, { where('status =?' = true) }
  scope :not_friends, { where('status =?' = false) }
end
