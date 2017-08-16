class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.string :title
      t.text :value
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
