class CreatePrices < ActiveRecord::Migration
  def change
    create_table :prices do |t|
      t.float :amount
      t.integer :currency_id
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
