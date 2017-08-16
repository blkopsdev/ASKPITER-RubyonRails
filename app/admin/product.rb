ActiveAdmin.register Product do

  controller do
    belongs_to :company, :user, :sub_category, optional: true

    def edit
      gon.product_id = params[:id]
      super
    end
  end

  permit_params :name, :description, :year, :url,
                :sub_category_id, :company_id,
                attrs_attributes: [:title, :value, :_destroy, :id],
                prices_attributes: [:amount, :currency_id, :_destroy, :id],
                dimensions_attributes: [:text, :_destroy, :id],
                pictures_attributes: %i(image _destroy id),
                :filter_option_ids => []

  action_item :videos, only: :show do
    link_to 'Videos', admin_product_videos_path(product)
  end

  action_item :photos, only: :show do
    link_to 'Photos', admin_product_photos_path(product)
  end

  action_item :ratings, only: :show do
    link_to 'Ratings', admin_product_ratings_path(product)
  end

  action_item :reviews, only: :show do
    link_to 'Reviews', admin_product_reviews_path(product)
  end

  action_item :users, only: :show do
    link_to 'Users', admin_product_users_path(product)
  end

  filter :name_cont, label: 'Name'
  filter :description_cont, label: 'Description'
  filter :year
  filter :sub_category
  filter :company

  show do
    panel 'Product Name' do
      attributes_table_for product do
        row :name
        row :description
        row :year
        row :url
        row :sub_category
        row :created_at
        row :updated_at
        row :company
      end
    end
    panel 'Pictures' do
      table_for product.pictures do
        column { |p| image_tag p.url :thumbnail }
      end
    end
    panel 'Prices' do
      table_for product.prices do
        column :amount
        column :currency
      end
    end
    panel 'Attributes' do
      table_for product.attrs do
        column :title
        column :value
      end
    end
    panel 'Dimenstions' do
      table_for product.dimensions do
        column :text
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :year
      f.input :url
      f.input :company
      f.input :sub_category
      f.input :filter_options, as: :grouped_check_boxes,
                               collection: FilterOption.includes(:filter).all.group_by(&:filter),
                               label: 'Filter Options'
    end
    f.inputs 'Pictures' do
      f.has_many :pictures, allow_destroy: true do |attr|
        attr.input :image, required: true, as: :file,
                           hint: (image_tag attr.object.url :thumbnail if attr.object.persisted?)
      end
    end
    f.inputs 'Prices' do
      f.has_many :prices, allow_destroy: true do |attr|
        attr.input :amount
        attr.input :currency
      end
    end
    f.inputs 'Attributes' do
      f.has_many :attrs, allow_destroy: true do |attr|
        attr.input :title
        attr.input :value
      end
    end
    f.inputs 'Dimensions' do
      f.has_many :dimensions, allow_destroy: true do |attr|
        attr.input :text
      end
    end
    f.actions
  end

end
