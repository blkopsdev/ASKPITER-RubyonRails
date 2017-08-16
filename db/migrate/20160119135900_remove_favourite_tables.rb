class RemoveFavouriteTables < ActiveRecord::Migration
  def change
    drop_table :favourite_categories
    drop_table :favourite_companies
    drop_table :favourite_photos
    drop_table :favourite_products
    drop_table :favourite_videos
  end
end
