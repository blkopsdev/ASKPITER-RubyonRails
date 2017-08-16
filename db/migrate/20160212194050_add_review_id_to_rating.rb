class AddReviewIdToRating < ActiveRecord::Migration
  def change
    add_column :ratings, :review_id, :integer
  end
end
