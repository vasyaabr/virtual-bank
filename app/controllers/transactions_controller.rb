class TransactionsController < ApplicationController

  def index
    @transactions = Transaction.all
  end

  def new
    # default: render 'new' template
  end

  def create
    @transaction = Transaction.create!(params[:transaction])
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
