class CreateDimensions < ActiveRecord::Migration
  def change
    create_table :dimensions do |t|
      t.string :text
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
