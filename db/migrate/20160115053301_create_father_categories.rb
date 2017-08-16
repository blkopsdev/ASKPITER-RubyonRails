class CreateFatherCategories < ActiveRecord::Migration
  def change
    create_table :father_categories do |t|

      t.string :name
      t.timestamps null: false
    end
  end
end
