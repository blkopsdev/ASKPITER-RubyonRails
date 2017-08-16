ActiveAdmin.register Distributor do

  belongs_to :company, optional: true

  permit_params :information, :phone, :url, :email,
                address_attributes: [:id, :street, :city, :postcode, :country, :latitude, :longitude, :addressable_type, :addressable_id]

  filter :information_cont, label: 'Information'
  filter :phone_cont, label: 'Phone'
  filter :email, label: 'Email'

  action_item :companies, only: :show do
    link_to 'Companies', admin_distributor_companies_path(distributor)
  end

  show do
    panel 'Distributor Details' do
      attributes_table_for distributor do
        row :information
        row :phone
        row :url
        row :email
        row :created_at
        row :updated_at
      end
    end
    panel 'Address' do
      attributes_table_for distributor.address do
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
      f.input :information
      f.input :phone
      f.input :url
      f.input :email
    end
    f.inputs 'Address', for: [:address_attributes, f.object.address || f.object.build_address] do |address|
      address.input :id, as: :hidden, value: address.object.id
      address.input :addressable_id, as: :hidden, value: f.object.id
      address.input :addressable_type, as: :hidden, value: 'Distributor'
      address.input :street
      address.input :postcode
      address.input :city
      address.input :country, as: :string
      address.input :latitude
      address.input :longitude
    end
    f.actions
  end

end
