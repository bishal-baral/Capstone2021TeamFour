class AddRecommendedToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :recommended, :boolean
  end
end
