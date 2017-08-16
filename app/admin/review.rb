ActiveAdmin.register Review do

  controller do
    belongs_to :user, :product, optional: true
  end

  permit_params :title, :review, :language_id, :user_id,
                :product_id

  filter :language
  filter :title_cont, label: 'Title'
  filter :review_cont, label: 'Review'

  index do
    selectable_column
    id_column
    column :title
    column :review
    column :language
    column :user
    column :product
    column :created_at
    actions
  end

end
