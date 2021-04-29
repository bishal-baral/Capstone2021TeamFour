class Review < ApplicationRecord
  has_one_attached :cover
  belongs_to :user
  has_many :review_tags
  has_many :tags, through: :review_tags
  validates :media, presence: true, length: { maximum: 100 }
  validates :content, presence: true, length: { maximum: 5000 }

  before_save do
    unless cover.attached?
      cover.attach(io: File.open('app/assets/images/cover.png'),
                   filename: 'cover.png',
                   content_type: 'image/png')
    end
  end
end
