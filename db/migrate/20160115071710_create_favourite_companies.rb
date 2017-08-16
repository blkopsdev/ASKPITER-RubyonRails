class CreateFavouriteCompanies < ActiveRecord::Migration
  def change
    create_table :favourite_companies do |t|
      t.integer :user_id
      t.integer :company_id

      t.timestamps null: false
    end
  end
end
