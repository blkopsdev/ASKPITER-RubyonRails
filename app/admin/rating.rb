ActiveAdmin.register Rating do

  permit_params :value, :user_id, :product_id

  controller do
    belongs_to :user, :product, optional: true
  end

  filter :value
  filter :created_at

  index do
    selectable_column
    id_column
    column :value
    column :product
    column :user
    actions
  end

end
