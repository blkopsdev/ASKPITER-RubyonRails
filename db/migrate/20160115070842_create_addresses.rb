class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :postcode
      t.string :city
      t.string :country
      t.float :latitude
      t.float :longitude
      t.integer :addressable_id
      t.string :addressable_type

      t.timestamps null: false
    end
  end
end
