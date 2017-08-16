ActiveAdmin.register Company do

  controller do
    belongs_to :user, :distributor, optional: true
  end

  permit_params :name, :url, :description, :international,
                :email, :phone, :fax,
                address_attributes: [:id, :street, :city, :postcode, :country, :latitude, :longitude, :addressable_type, :addressable_id],
                user_ids: []

  scope :all

  filter :name_cont, label: 'Name'
  filter :description_cont, label: 'Description'
  filter :email_cont, label: 'Email'
  filter :phone_cont, label: 'Phone'
  filter :fax_cont, label: 'Fax'
  filter :created_at

  action_item :products, only: :show do
    link_to 'Products', admin_company_products_path(company)
  end

  action_item :distributors, only: :show do
    link_to 'Distributors', admin_company_distributors_path(company)
  end

  action_item :users, only: :show do
    link_to 'Users', admin_company_users_path(company)
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :url
      f.input :description
      f.input :email
      f.input :phone
      f.input :fax
    end
    f.inputs 'Address', for: [:address_attributes, f.object.address || f.object.build_address] do |address|
      address.input :id, as: :hidden, value: address.object.id
      address.input :addressable_id, as: :hidden, value: f.object.id
      address.input :addressable_type, as: :hidden, value: 'Company'
      address.input :street
      address.input :postcode
      address.input :city
      address.input :country, as: :string
      address.input :country_code
      address.input :latitude
      address.input :longitude
    end
    f.inputs 'Users' do
      f.input :users, as: :check_boxes
    end
    f.actions
  end

end
