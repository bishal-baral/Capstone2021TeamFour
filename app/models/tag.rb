class Tag < ApplicationRecord
  has_many :review_tags
  attribute :category, :string, default: 'other'
  validates :category, presence: true, length: { maximum: 20 }
  validates :name, presence: true, length: { maximum: 30 }
end
