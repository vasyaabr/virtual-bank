#encoding: utf-8
class TransactionsController < ApplicationController
  before_filter :authenticate
  before_filter :isadmin?, :only => [:edit, :update, :destroy]

  def index
    if session[:admin]
      @transactions = Transaction.order("change_date ASC")
    #else
    #  @transactions = Transaction.where(:from => session[:acc].account).order("change_date ASC")
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    if params[:transaction][:from]
      @from = Account.find_by_account params[:transaction][:from].gsub(/-/,'')
    else
      @from = Account.find_by_account session[:acc].account
    end
    if @from.active != 1
      flash[:notice] = "Счет блокирован."
      #audit_log.info 'Blocked: '+@from.account
      redirect_to session[:admin] ? new_transaction_path : root_url
      return
    end
    if @from.credit != 1 && @from.sum < params[:transaction][:sum].to_i
      flash[:notice] = "У вас недостаточно средств, а кредит запрещен."
      #audit_log.info 'Lack of money: '+@from.account
      redirect_to session[:admin] ? new_transaction_path : root_url
      return
    end
    if @from.sum < params[:transaction][:sum].to_i || @from.credit == 1 && @from.sum+@from.creditsum < params[:transaction][:sum].to_i
      flash[:notice] = "Кредитный лимит недостаточен."
      #audit_log.info 'Lack of money+credit: '+@from.account
      redirect_to session[:admin] ? new_transaction_path : root_url
      return
    end

    @to = Account.find_by_account params[:transaction][:to].gsub(/-/,'')
    if @to == nil
      flash[:notice] = "Неверный счет получателя."
      redirect_to session[:admin] ? new_transaction_path : root_url
      return
    end

    if @from.account == @to.account
      flash[:notice] = "Запрещенная операция (нельзя переводить самому себе)."
      redirect_to session[:admin] ? new_transaction_path : root_url
      return
    end

    if params[:transaction][:sum].to_i <= 0
      flash[:notice] = "Запрещенная операция (сумма должна быть больше нуля)."
      redirect_to session[:admin] ? new_transaction_path : root_url
      return
    end

    @transaction = Transaction.new(:from => @from.account, 
      :to => @to.account,
      :change_date => params[:transaction][:change_date] == nil ? (Time.now.utc+60*60*4) : params[:transaction][:change_date], 
      :sum => params[:transaction][:sum],
      :comment => params[:transaction][:comment])
    @transaction.save
    #audit_log.info 'Transaction added: '+params[]

    @from.sum -= params[:transaction][:sum].to_i
    @from.save
    #audit_log.info 'Sum changed for '+@from.account+', amount: -'+params[:transaction][:sum]

    @to.sum += params[:transaction][:sum].to_i
    @to.save
    #audit_log.info 'Sum changed for '+@to.account+', amount: +'+params[:transaction][:sum]

    if @from.mail != '' and @from.mail != nil
      Notifier.transaction_from_notification(@from,@transaction).deliver
    end
    if @to.mail != '' and @to.mail != nil
      Notifier.transaction_to_notification(@to,@transaction).deliver
    end

    flash[:notice] = "Операция успешно проведена."
    redirect_to root_url
  end

  def edit
    @transaction = Transaction.find params[:id]
  end

  def update
    @transaction = Transaction.find params[:id]
    @transaction.update_attributes!(params[:transaction])
    flash[:notice] = "Транзакция обновлена."
    redirect_to transactions_path
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    flash[:notice] = "Транзакция удалена."
    redirect_to transactions_path
  end

end
