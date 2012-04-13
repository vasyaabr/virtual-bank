class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.all
  end

  def new
    # default: render 'new' template
  end

  def create
    if params[:transaction][:from] == params[:transaction][:to]
      flash[:notice] = "Disallowed operation (you cannot made transaction to self)."
      redirect_to params[:transaction][:pass] != nil ? root_url : new_transaction_path
      return
    end

    @from = Account.find_by_account params[:transaction][:from]
    if @from == nil
      flash[:notice] = "Invalid from account."
      redirect_to params[:transaction][:pass] != nil ? root_url : new_transaction_path
      return
    end
    if @from.active != 1
      flash[:notice] = "From account blocked."
      redirect_to params[:transaction][:pass] != nil ? root_url : new_transaction_path
      return
    end
    if params[:transaction][:pass] != nil
      if @from.pass != params[:transaction][:pass]
        flash[:notice] = "Invalid password."
        redirect_to root_url
        return
      end
    end
    if @from.credit != 1 && @from.sum < params[:transaction][:sum].to_i
      flash[:notice] = "You haven't so much money and credit not allowed."
      redirect_to params[:transaction][:pass] != nil ? root_url : new_transaction_path
      return
    end

    @to = Account.find_by_account params[:transaction][:to]
    if @to == nil
      flash[:notice] = "Invalid to account."
      redirect_to params[:transaction][:pass] != nil ? root_url : new_transaction_path
      return
    end

    @transaction = Transaction.new(:from => params[:transaction][:from], 
      :to => params[:transaction][:to],
      :change_date => params[:transaction][:change_date] == nil ? Time.now : params[:transaction][:change_date], 
      :sum => params[:transaction][:sum])
    @transaction.save
    @from.sum -= params[:transaction][:sum].to_i
    @from.save
    @to.sum += params[:transaction][:sum].to_i
    @to.save

    flash[:notice] = "Transaction was successfully created."
    redirect_to transactions_path
  end

  def edit
    @transaction = Transaction.find params[:id]
  end

  def update
    @transaction = Transaction.find params[:id]
    @transaction.update_attributes!(params[:transaction])
    flash[:notice] = "Transaction was successfully updated."
    redirect_to transactions_path
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    flash[:notice] = "Transaction deleted."
    redirect_to transactions_path
  end

end
