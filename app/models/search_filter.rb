class SearchFilter

  attr_accessor :name, :type, :id, :obj

  def initialize(init)
    init.each_pair do |key, val|
      instance_variable_set('@' + key.to_s, val)
    end
  end

  def self.build( params )

    filters = Array.new
    # filters << build_category_filter(params) if params[:category_id] and !params[:sub_category_id]
    filters += build_sub_categories_filter(params) if params[:sub_categories]
    filters += build_companies_filter(params) if params[:companies]
    filters << build_search_filter(params) if params[:search] and !params[:search].blank?
    filters
  end

  def self.build_sub_categories_filter( params )
    sub_categories = SubCategory.where( id: params[:sub_categories] )
    sub_categories.map {|sub_category| SearchFilter.new( name: sub_category.name,
                                                         type: :sub_categories,
                                                         id: sub_category.id,
                                                         obj: sub_category )}
  end

  def self.build_companies_filter( params )
    companies = Company.where( id: params[:companies] )
    companies.map {|company| SearchFilter.new( name: company.name,
                                               type: :companies,
                                               id: company.id,
                                               obj: company )}
  end

  def self.build_search_filter( params )
    SearchFilter.new( name: params[:search], type: :search )
  end
end
