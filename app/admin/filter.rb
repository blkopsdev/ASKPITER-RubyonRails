ActiveAdmin.register Filter do



  permit_params :name, :sub_category_id,
                filter_options_attributes: [:id, :filter_id, :name, :_destroy]

  index do
    id_column
    column :name
    column :created_at
    column :updated_at
    actions
  end


  show do |order|
    attributes_table do
      row :name
      row :sub_category
    end
    table_for filter.filter_options, sortable: true, class: 'index_table' do
      column :filter_options do |fo|
        fo.name
      end
    end
  end


  form do |f|
    f.inputs do
      f.input :sub_category
      f.input :name
    end

    f.inputs "Filter Options" do
      f.has_many :filter_options, allow_destroy: true, new_record: true do |fo|
        fo.input :name
      end
    end

    f.actions

  end

end
