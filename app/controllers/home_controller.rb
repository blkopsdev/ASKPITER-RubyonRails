class HomeController < ApplicationController

  def index
        if session[:return] == "yes"
           redirect_to url_for(:controller => :search, :action => :index)
        else
           session[:return] = "yes"
        end
  end

end


