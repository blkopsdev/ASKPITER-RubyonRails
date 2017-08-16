class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :value

      t.timestamps null: false
    end
  end
end
