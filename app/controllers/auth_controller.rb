#encoding: utf-8
class AuthController < ApplicationController

  def auth
    # render auth form
  end

  def setauth
    @user = Account.find_by_account_and_pass params[:auth][:account], params[:auth][:pass]
    if @user == nil
      flash[:notice] = "Неправильный счет или пин-код."
      redirect_to auth_path
      return
    end
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
