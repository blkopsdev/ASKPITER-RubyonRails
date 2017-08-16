ActiveAdmin.register FatherCategory do

  permit_params :name

  filter :name
  filter :created_at

  action_item :categories, only: :show do
    link_to 'Categories', admin_father_category_categories_path(father_category)
  end

  index do
    id_column
    column :name
    column :created_at
    column :updated_at
    actions
  end

end
