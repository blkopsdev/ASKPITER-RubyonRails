class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :name
      t.float :exchange_rate
      t.string :sign
      t.string :code

      t.timestamps null: false
    end
  end
end
