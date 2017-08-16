ActiveAdmin.register User do

  controller do
    belongs_to :company, :category, :product, :video, :photo, optional: true
  end

  permit_params do
    basic_params = [
        :email, :name, :password, :password_confirmation,
        :role, :currency_id, :language_id, :last_name,
        :dob, :sex, :company,
        address_attributes: [:id, :street, :city, :postcode, :country, :latitude, :longitude, :addressable_type, :addressable_id],
        picture_attributes: [:id, :title, :url, :imageable_id, :imageable_type],
        category_ids: [], company_ids: [], product_ids: []
    ]
    if params[:user] && params[:user][:password].blank?
      params[:user].delete :password
      params[:user].delete :password_confirmation
    end
    basic_params
  end

  filter :role, as: :select, collection: User.roles
  filter :email_cont, label: 'Email'
  filter :name_or_last_name_cont, label: 'Name'

  action_item :ratings, only: :show do
    link_to 'Ratings', admin_user_ratings_path(user)
  end

  action_item :favourite_categories, only: :show do
    link_to 'Favourite Categories', admin_user_categories_path(user)
  end

  action_item :favourite_companies, only: :show do
    link_to 'Favourite Companies', admin_user_companies_path(user)
  end

  action_item :favourite_products, only: :show do
    link_to 'Favourite Products', admin_user_products_path(user)
  end

  action_item :videos, only: :show do
    link_to 'Videos', admin_user_videos_path(user)
  end

  action_item :photos, only: :show do
    link_to 'Photos', admin_user_photos_path(user)
  end

  action_item :reviews, only: :show do
    link_to 'Reviews', admin_user_reviews_path(user)
  end


  index do
    column :id
    column :email
    column :name
    column :last_name
    column :language
    column :dob
    column :sex
    column :company
    column :role
    column :created_at
    actions
  end

  show do
    panel 'User Details' do
      attributes_table_for user do
        row :id
        row :email
        row :reset_password_sent_at
        row :remember_created_at
        row :sign_in_count
        row :current_sign_in_at
        row :last_sign_in_at
        row :current_sign_in_ip
        row :last_sign_in_ip
        row :created_at
        row :updated_at
        row :name
        row :confirmed_at
        row :confirmation_sent_at
        row :unconfirmed_email
        row :role
        row :currency
        row :language
        row :last_name
        row :dob
        row :sex
        row :company
        row :picture
      end
    end
    panel 'Address' do
      attributes_table_for user.address do
        row :street
        row :postcode
        row :city
        row :country
        row :latitude
        row :longitude
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :role, as: :select, collection: User.roles.keys
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :name
      f.input :last_name
      f.input :currency
      f.input :language
      f.input :dob
      f.input :sex
      f.input :company
    end
    f.inputs 'Address', for: [:address_attributes, f.object.address || f.object.build_address] do |address|
      address.input :id, as: :hidden, value: address.object.id
      address.input :addressable_id, as: :hidden, value: f.object.id
      address.input :addressable_type, as: :hidden, value: 'User'
      address.input :street
      address.input :postcode
      address.input :city
      address.input :country, as: :string
      address.input :latitude
      address.input :longitude
    end
    f.inputs 'Picture', for: [:picture_attributes, f.object.picture || f.object.build_picture] do |picture|
      picture.input :id, as: :hidden, value: picture.object.id
      picture.input :imageable_id, as: :hidden, value: f.object.id
      picture.input :imageable_type, as: :hidden, value: 'User'
      picture.input :title
      picture.input :url
    end
    f.inputs 'Favourite Categories' do
      f.input :categories, as: :check_boxes
    end
    f.inputs 'Favourite Companies' do
      f.input :companies, as: :check_boxes
    end
    f.inputs 'Favourite Products' do
      f.input :products, as: :check_boxes
    end
    f.actions
  end

end
