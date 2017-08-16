class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :url
      t.text :description
      t.boolean :international
      t.string :email
      t.string :phone
      t.string :fax

      t.timestamps null: false
    end
  end
end
