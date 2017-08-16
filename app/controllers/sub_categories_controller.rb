class SubCategoriesController < ApplicationController
  def show
    @sub_category = SubCategory.find(params[:id])
    @products = @sub_category.products.filter(params[:filters])
                                      .companies(params[:companies])
                                      .year_from(params[:year_from])
                                      .year_to(params[:year_to])
                                      .price_from(params[:price_from])
                                      .price_to(params[:price_to])
    @filters = @sub_category.filters

    respond_to do |format|
      format.js { render 'success', layout: false }
      format.html
    end
  end
end
