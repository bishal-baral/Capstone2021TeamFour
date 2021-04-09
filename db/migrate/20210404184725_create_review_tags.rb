class CreateReviewTags < ActiveRecord::Migration[6.1]
  def change
    create_table :review_tags do |t|
      t.belongs_to :tag
      t.belongs_to :review
    end
  end
end
