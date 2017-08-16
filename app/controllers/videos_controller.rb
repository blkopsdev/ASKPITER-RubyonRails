class VideosController < ApplicationController
  include ImitateDelay
  imitate_delay only: :create
  before_action :set_video, only:[:show]
  before_action :set_product, only:[:show]

  def show
    @more_videos = @product.videos.last_videos(except:@video, limit:7)
  end

  def create
    video = Video.new creation_params.merge! main: false, day: false, user: current_user
    if video.save
      redirect_to :back
    else
      render 'shared/errors', locals: { errors: video.errors }
    end
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end

  def set_product
    @product = @video.product
  end

  def creation_params
    params.require(:video).permit %i(url title comment product_id category_id)
  end
end
