class CreateFavouriteProducts < ActiveRecord::Migration
  def change
    create_table :favourite_products do |t|
      t.integer :user_id
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
