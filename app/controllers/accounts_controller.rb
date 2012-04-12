class AccountsController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @account = Account.find(id) # look up movie by unique ID
    # will render app/views/accounts/show.<extension> by default
  end

  def index
    @accounts = Account.all
  end

  def new
    # default: render 'new' template
  end

  def create
    @account = Account.create!(params[:account])
    flash[:notice] = "#{@account.name} was successfully created."
    redirect_to accounts_path
  end

  def edit
    @account = Account.find params[:id]
  end

  def update
    @account = Account.find params[:id]
    @account.update_attributes!(params[:account])
    flash[:notice] = "#{@account.name} was successfully updated."
    redirect_to account_path(@account)
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    flash[:notice] = "Account '#{@account.name}' deleted."
    redirect_to accounts_path
  end

end
