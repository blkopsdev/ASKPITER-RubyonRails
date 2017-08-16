class CreateFilterOptionsProducts < ActiveRecord::Migration
  def change
    create_table :filter_options_products do |t|
      t.references :product, index: true, foreign_key: true
      t.references :filter_option, index: true, foreign_key: true

      t.timestamps
    end
  end
end
