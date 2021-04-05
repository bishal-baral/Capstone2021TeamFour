class CreateReviewTags < ActiveRecord::Migration[6.1]
  def change
    create_table :review_tags do |t|
      t.belongs_to :tag
      t.belongs_to :review
      t.integer :review_id
      t.integer :tag_id
    end
  end
end
