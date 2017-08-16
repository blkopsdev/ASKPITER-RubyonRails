module AddendumHelper

  def addendum_storage prefix
    return unless categories = @categories
    capture do

      data = { owner: "#{prefix}_category_id", dependant: "#{prefix}_product_id" }
      grouped_collection_select nil, nil, @categories, :products, :id, :id, :name, {},
                                name: nil, id: nil, class: 'storage hidden', data: data

    end
  end
end
