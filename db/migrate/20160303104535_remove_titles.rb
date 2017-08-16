class RemoveTitles < ActiveRecord::Migration
  def change
    remove_column :pictures, :title, :string
    remove_column :videos, :title, :string
  end
end
