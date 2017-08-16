class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, :except => [:review, :photo, :video, :show, :ajax_destroy_favourite, :ajax_destroy_recent_search,
                                          :ajax_destroy_all_favourites, :ajax_destroy_recent_searches]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        redirect_to :back, :alert => "Access denied."
      end
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  def ajax_destroy_recent_search
    @filter_id = params[:filter_id]
    search = Search.where(id: @filter_id, user_id: current_user.id).last
    respond_to do |format|
      if search.destroy
        format.js
      else
        format.js { render js: "alert('Something went wrong!');" }
      end
    end
  end

  def ajax_destroy_favourite
    @favourite_name = params[:favourite_name]
    @favourite_id = params[:favourite_id]
    favourite = UserFavourite.where(user_id: current_user.id, favouriteable_id: @favourite_id,
                                    favouriteable_type: @favourite_name).last
    respond_to do |format|
      if favourite.destroy
        format.js
      else
        format.js { render js: "alert('Something went wrong!');" }
      end
    end
  end

  def ajax_destroy_all_favourites
    favourites = current_user.favourites
    respond_to do |format|
      if favourites.destroy_all
        format.js
      else
        format.js { render js: "alert('Something went wrong!');" }
      end
    end
  end

  def ajax_destroy_recent_searches
    searches = current_user.searches.recent
    respond_to do |format|
      if searches.map(&:destroy)
        format.js
      else
        format.js { render js: "alert('Something went wrong!');" }
      end
    end
  end

  def review
    @media = ProductSearchService.new(params).search.media.select { |media| media.is_a?(Review) }

    @media = Kaminari.paginate_array(@media)
                     .page(params[:page])
                     .per(16)

    if request.xhr?
      render partial: 'review_result'
    else
      @categories = Category.includes(:sub_categories).all
      render
    end
  end

  def photo
    @media = ProductSearchService.new(params).search.media.select { |media| media.is_a?(Photo) }

    @media = Kaminari.paginate_array(@media)
                     .page(params[:page])
                     .per(16)
    if request.xhr?
      render partial: 'photo_result'
    else
      @categories = Category.includes(:sub_categories).all
      render
    end
  end

  def video
    @media = ProductSearchService.new(params).search.media.select { |media| media.is_a?(Video) }

    @media = Kaminari.paginate_array(@media)
                     .page(params[:page])
                     .per(16)
    if request.xhr?
      render partial: 'video_result'
    else
      @categories = Category.includes(:sub_categories).all
      render
    end
  end

  private

  def admin_only
    unless current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end

  def secure_params
    params.require(:user).permit(:role)
  end

end
