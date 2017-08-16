class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.string :url
      t.boolean :main
      t.text :comment
      t.boolean :day
      t.string :caption
      t.integer :product_id
      t.integer :user_id
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
