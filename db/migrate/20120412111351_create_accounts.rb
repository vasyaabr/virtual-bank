class CreateAccounts < ActiveRecord::Migration
  MORE_ACCOUNTS = [
    {:name => 'Basil_test', :account => '1234', :pass => '1234', :sum => 500, :credit => 1, :mail => 'vasyaabr@gmail.com', :active => 1},
    {:name => 'Gil_test', :account => '5678', :pass => '1234', :sum => 1000, :credit => 1, :mail => 'vasyaabr@gmail.com', :active => 1},
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
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
    MORE_ACCOUNTS.each do |acc|
      Account.create!(acc)
    end
  end

  def down
    drop_table :accounts
  end
end
