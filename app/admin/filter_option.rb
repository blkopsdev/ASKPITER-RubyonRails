ActiveAdmin.register FilterOption do

  permit_params :name, :filter_id

  index do
    id_column
    column :name
    column :created_at
    column :updated_at
    actions
  end


end
