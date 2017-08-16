class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :last_name, :string
    add_column :users, :dob, :date
    add_column :users, :sex, :integer
    add_column :users, :company, :boolean
  end
end
