class Tag < ApplicationRecord
  has_many :review_tags
  before_save { self.category = category.capitalize }
  attribute :category, :string, default: 'Other'
  validates :category, presence: true, length: { maximum: 20 }
  before_save { self.name = name.capitalize }
  validates :name, presence: true, length: { maximum: 30 }
end
