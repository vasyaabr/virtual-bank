#encoding: utf-8
class TransactionsController < ApplicationController
  before_filter :authenticate
  before_filter :isadmin?, :only => [:edit, :update, :destroy]

  def index
    if session[:admin]
      @transactions = Transaction.all
    else
      @transactions = Transaction.where(:from => session[:acc].account)
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @from = Account.find_by_account session[:acc].account
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

    @to = Account.find_by_account params[:transaction][:to]
    if @to == nil
      flash[:notice] = "Неверный счет получателя."
      redirect_to session[:admin] ? new_transaction_path : root_url
      return
    end

    if session[:acc].account == params[:transaction][:to]
      flash[:notice] = "Запрещенная операция (нельзя переводить самому себе)."
      redirect_to session[:admin] ? new_transaction_path : root_url
      return
    end

    @transaction = Transaction.new(:from => session[:acc].account, 
      :to => params[:transaction][:to],
      :change_date => params[:transaction][:change_date] == nil ? Time.now : params[:transaction][:change_date], 
      :sum => params[:transaction][:sum])
    @transaction.save
    #audit_log.info 'Transaction added: '+params[]

    @from.sum -= params[:transaction][:sum].to_i
    @from.save
    #audit_log.info 'Sum changed for '+@from.account+', amount: -'+params[:transaction][:sum]

    @to.sum += params[:transaction][:sum].to_i
    @to.save
    #audit_log.info 'Sum changed for '+@to.account+', amount: +'+params[:transaction][:sum]

    flash[:notice] = "Операция успешно проведена."
    redirect_to transactions_path
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
