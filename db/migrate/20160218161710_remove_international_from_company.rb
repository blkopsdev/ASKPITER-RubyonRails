class RemoveInternationalFromCompany < ActiveRecord::Migration
  def change
    remove_column :companies, :international, :boolean
  end
end
