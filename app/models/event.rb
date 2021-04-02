class Event < ApplicationRecord
  belongs_to :user
  has_many :invitees

  # needs a stream link validation, but don't have any links for those yet...
  validates :title, presence: true, length: { maximum: 50 }
  validates :scheduled_time, presence: true
end
