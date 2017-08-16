class ProductsController < ApplicationController
  include HelperAttr
  helper_attr :product, :pictures, :reviews, :photos, :videos, :similars
  before_action :set_product, only:[:show]

  def show
    @pictures = product.pictures.recent.first(6)
    @reviews = product.reviews.recent.first(3)
    @simpage = (params[:similar] || '1').to_i
    if @simpage == 1
      @similars = Kaminari.paginate_array(product.similars.recent)
                     .page(@simpage)
                     .per(2)
    else
      @similars = Kaminari.paginate_array(product.similars.recent)
                     .page(@simpage)
                     .per(10).padding(-8)
    end
    @photopage = (params[:photo] || '1').to_i
    if @photopage == 1
      @photos = Kaminari.paginate_array(product.photos.recent)
                     .page(@photopage)
                     .per(2)
    else
      @photos = Kaminari.paginate_array(product.photos.recent)
                     .page(@photopage)
                     .per(10).padding(-8)
    end
    @videopage = (params[:video] || '1').to_i
    if @videopage == 1
      @videos = Kaminari.paginate_array(product.videos.recent)
                     .page(@videopage)
                     .per(2)
    else
      @videos = Kaminari.paginate_array(product.videos.recent)
                     .page(@videopage)
                     .per(10).padding(-8)
    end
    if request.xhr?
      if params[:similar]
        render partial: 'product_similar', locals: { results: @similars }
      end
      if params[:photo]
        render partial: 'product_photo', locals: { results: @photos }
      end
      if params[:video]
        render partial: 'product_video', locals: { results: @videos }
      end

    else
      render
    end
  end

    def set_filter_options
      @product = Product.find(params[:product_id]) if params[:product_id].present?

      sub_category = SubCategory.find(params[:id])
      @filter_options = sub_category.filter_options

      respond_to do |format|
         format.html { render :layout => false }
         format.js {}
      end
    end

  private

  def set_product
    @product = Product.find params[:id]
  end
end
