class AddCountryCodeToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :country_code, :string
  end
end
