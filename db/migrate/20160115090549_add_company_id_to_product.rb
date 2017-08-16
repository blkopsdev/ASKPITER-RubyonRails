class AddCompanyIdToProduct < ActiveRecord::Migration
  def change
    add_column :products, :company_id, :integer
  end
end
