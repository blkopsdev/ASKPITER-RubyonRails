class UserFavouriteProductsController < ApplicationController

  before_action :set_product, only:[:add, :remove]

  def add
    UserFavourite.add_to_favourites(user:current_user, element:@product)
    redirect_to :back
  end

  def remove
    UserFavourite.remove_from_favourites(user:current_user, element:@product)
    redirect_to :back
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

end
