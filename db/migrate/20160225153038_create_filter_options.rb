class CreateFilterOptions < ActiveRecord::Migration
  def change
    create_table :filter_options do |t|
      t.references :filter, index: true, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
