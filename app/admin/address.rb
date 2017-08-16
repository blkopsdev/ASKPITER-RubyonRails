ActiveAdmin.register Address do

  actions :index, :show, :destroy

  filter :postcode
  filter :country
  filter :city
  filter :street
  filter :created_at

  index do
    id_column
    column :addressable
    column :postcode
    column :country
    column :city
    column :street
    column :created_at
    actions
  end

end
