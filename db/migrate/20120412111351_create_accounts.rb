class CreateAccounts < ActiveRecord::Migration
  MORE_ACCOUNTS = [
    {:name => 'Basil', :account => '9211147767', :pass => '1234', :sum => 500, :credit => 1, :mail => 'vasyaabr@gmail.com', :active => 1},
  ]
  def up
    create_table :accounts do |t|
      t.string :name
      t.string :account
      t.string :pass
      t.integer :sum
      t.integer :credit
      t.string :mail
      t.integer :active
    end
    MORE_ACCOUNTS.each do |acc|
      Account.create!(acc)
    end
  end

  def down
    drop_table :accounts
  end
end
