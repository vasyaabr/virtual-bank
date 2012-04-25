class ApplicationController < ActionController::Base
  protect_from_forgery

  private
    def authenticate
      unless session[:acc]
      
        #@ban = Ban.find_by_ip(request.remote_ip)
        #if @ban
        #  if @ban.banned_till > Time.now
        #    redirect_to "http://natribu.org/"
        #    return false
        #  end
        #end

        #Ban.where("banned_till < ?", Time.now) do |expired|
        #  expired.destroy
        #end
      
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
