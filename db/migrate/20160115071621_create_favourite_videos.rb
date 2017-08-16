class CreateFavouriteVideos < ActiveRecord::Migration
  def change
    create_table :favourite_videos do |t|
      t.integer :user_id
      t.integer :video_id

      t.timestamps null: false
    end
  end
end
