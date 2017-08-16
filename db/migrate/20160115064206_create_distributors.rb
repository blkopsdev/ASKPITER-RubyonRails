class CreateDistributors < ActiveRecord::Migration
  def change
    create_table :distributors do |t|
      t.text :information
      t.string :phone
      t.string :url
      t.string :email

      t.timestamps null: false
    end
  end
end
