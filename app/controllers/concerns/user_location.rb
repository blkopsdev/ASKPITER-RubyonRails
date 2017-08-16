module UserLocation
  extend ActiveSupport::Concern

  included do
    before_action :get_user_location
  end

  def get_user_location
    @user_country = country_code_from_account || country_code_from_cookies
  end

  def country_code_from_account
    current_user && current_user.address && current_user.address.country_code
  end

  def country_code_from_cookies
    cookies[:country_code] ||= request.location && request.location.country_code
  end

end
