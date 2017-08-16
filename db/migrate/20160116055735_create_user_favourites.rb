class CreateUserFavourites < ActiveRecord::Migration
  def change
    create_table :user_favourites do |t|
      t.references :user, index: true, foreign_key: true
      t.references :favouriteable, polymorphic: true, index: { name: 'favouriteable_polymorphic_index' }

      t.timestamps null: false
    end
  end
end
