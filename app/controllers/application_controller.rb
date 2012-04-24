class ApplicationController < ActionController::Base
  protect_from_forgery

  private
    def authenticate
      unless session[:acc]
        #flash[:notice] = "You must be logged in to access this page"
        redirect_to auth_url
        return false
      end
    end

    def isadmin?
      unless session[:admin]
        #flash[:notice] = "You must be admin to access this page"
        redirect_to root_url
        return false
      end
    end

end
