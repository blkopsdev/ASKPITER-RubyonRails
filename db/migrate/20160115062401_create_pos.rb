class CreatePos < ActiveRecord::Migration
  def change
    create_table :pos do |t|
      t.integer :company_id
      t.integer :distributor_id

      t.timestamps null: false
    end
  end
end
