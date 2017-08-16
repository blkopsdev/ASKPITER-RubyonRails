class CreateFilters < ActiveRecord::Migration
  def change
    create_table :filters do |t|
      t.references :sub_category, index: true, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
