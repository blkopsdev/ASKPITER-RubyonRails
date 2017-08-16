ActiveAdmin.register Photo do

  controller do
    belongs_to :user, :category, :product, optional: true
  end

  permit_params :category_id, :product_id, :user_id,
                :main, :comment, :day,
                picture_attributes: %i(id imageable_id imageable_type image)

  action_item :users, only: :show do
    link_to 'Users', admin_photo_users_path(resource)
  end

  filter :main
  filter :day
  filter :comment_cont, label: 'Comment'
  filter :created_at

  index do
    selectable_column
    id_column
    column :main
    column :comment
    column :day
    column :category
    column :product
    column :user
    column :created_at
    actions
  end

  sidebar :picture, only: :show do
    image_tag photo.url :thumbnail
  end

  form do |f|
    f.inputs do
      f.input :category
      f.input :product
      f.input :user
      f.input :main
      f.input :comment
      f.input :day
    end
    f.inputs 'Picture', for: [:picture_attributes, f.object.picture || f.object.build_picture] do |picture|
      picture.input :id, as: :hidden, value: picture.object.id
      picture.input :imageable_id, as: :hidden, value: f.object.id
      picture.input :imageable_type, as: :hidden, value: 'Photo'
      picture.input :image, required: true, as: :file,
                            hint: (image_tag picture.object.url :thumbnail if picture.object.persisted?)
    end
    actions
  end

end
