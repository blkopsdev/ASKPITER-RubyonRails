class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :year
      t.string :url
      t.integer :sub_category_id

      t.timestamps null: false
    end
  end
end
