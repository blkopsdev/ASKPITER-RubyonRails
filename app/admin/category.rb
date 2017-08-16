ActiveAdmin.register Category do

  # belongs_to :father_category, optional: true
  belongs_to :user, optional: true

  permit_params :name, :father_category_id

  action_item :sub_categories, only: :show do
    link_to 'Sub Categories', admin_category_sub_categories_path(category)
  end

  action_item :videos, only: :show do
    link_to 'Videos', admin_category_videos_path(category)
  end

  action_item :photos, only: :show do
    link_to 'Photos', admin_category_photos_path(category)
  end

  action_item :users, only: :show do
    link_to 'Users', admin_category_users_path(category)
  end

  filter :name
  filter :father_category
  filter :created_at

  index do
    id_column
    column :name
    column :father_category
    column :created_at
    column :updated_at
    actions
  end

end
