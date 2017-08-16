class ReviewsController < ApplicationController

  before_action :set_product, only:[:new, :create]

  def new
    @review = Review.new
    @review.build_rating(value: Rating::DEFAULT_VALUE)
  end

  def create
    @review = Review.new(review_params.merge(review_extra_params))
    if @review.save!
      redirect_to product_path(@product)
    else
      render 'new'
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def review_params
    params.require(:review).permit(:title, :review, rating_attributes: [:value])

  end

  def review_extra_params
    { user_id: current_user.id,
      product_id: @product.id,
      language_id: current_user.language_id }
  end

end
