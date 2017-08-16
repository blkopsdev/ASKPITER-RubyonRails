ActiveAdmin.register Video do

  permit_params :category_id, :product_id, :user_id, :title,
                :url, :main, :comment, :day, :caption,
                picture_attributes: [:id, :title, :url, :imageable_id, :imageable_type]

  controller do
    belongs_to :user, :category, :product, optional: true
  end

  action_item :users, only: :show do
    link_to 'Users', admin_video_users_path(resource)
  end

  filter :main
  filter :day
  filter :title_cont, label: 'Title'
  filter :comment_cont, label: 'Comment'
  filter :caption_cont, label: 'Caption'
  filter :created_at

  index do
    selectable_column
    id_column
    column :title
    column :url
    column :main
    column :comment
    column :day
    column :caption
    column :category
    column :product
    column :user
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :category
      f.input :product
      f.input :user
      f.input :title
      f.input :url
      f.input :main
      f.input :comment
      f.input :day
      f.input :caption
    end
    f.inputs 'Picture', for: [:picture_attributes, f.object.picture || f.object.build_picture] do |picture|
      picture.input :id, as: :hidden, value: picture.object.id
      picture.input :imageable_id, as: :hidden, value: f.object.id
      picture.input :imageable_type, as: :hidden, value: 'Video'
      picture.input :title
      picture.input :url
    end
    actions
  end

end
