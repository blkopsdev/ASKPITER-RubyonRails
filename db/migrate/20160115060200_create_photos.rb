class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.boolean :main
      t.text :comment
      t.boolean :day
      t.integer :product_id
      t.integer :user_id
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
