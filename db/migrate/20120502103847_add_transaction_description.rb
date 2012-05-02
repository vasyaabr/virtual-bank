class AddTransactionDescription < ActiveRecord::Migration
  def up
  	add_column :transactions, :comment, :string
  end

  def down
  	remove_column :transactions, :comment, :string
  end
end
