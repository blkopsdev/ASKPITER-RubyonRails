class PhotosController < ApplicationController
  include ImitateDelay
  imitate_delay only: :create
  before_action :set_photo, only:[:show]
  before_action :set_product, only:[:show]

  def show
    @more_photos = @product.photos.last_photos(except:@photo, limit:7)
  end

  def create
    photo = Photo.new creation_params.merge! main: false, day: false, user: current_user
    if photo.save
      redirect_to :back
    else
      render 'shared/errors', locals: { errors: photo.errors }
    end
  end

  private

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def set_product
    @product = @photo.product
  end

  def creation_params
    params.require(:photo).permit %i(comment product_id category_id),
                                  picture_attributes: %i(title image)
  end
end
