#encoding: utf-8
class AuthController < ApplicationController

  def auth
    # render auth form
  end

  def setauth
    @user = Account.find_by_account_and_pass params[:auth][:account].gsub(/-/,''), params[:auth][:pass]
    if @user == nil
      # update false logins table
      #@ban = Ban.find_by_ip request.remote_ip
      #if @ban == nil
      #  @ban = Ban.create!(:ip => request.remote_ip, :try => 1)
      #else
      #  @ban.try += 1
      #  if @ban.try > 9
      #    @ban.banned_till = Time.tomorrow
      #  end
      #  @ban.save
      #end

      flash[:notice] = "Неправильный счет или пин-код."
      redirect_to auth_path
      return
    end

    #Ban.where("ip = ?", request.remote_ip) do |expired|
    #  expired.destroy
    #end
    
    #flash[:notice] = "Login successful for account #{@user.account}, admin = #{@user.admin}."
    session[:acc] = @user
    if @user.admin == 1
      session[:admin] = @user.admin
    end
    redirect_to root_url
  end

  def logout
    reset_session
    redirect_to auth_url #, :notice => "You have successfully logged out"
  end

end
