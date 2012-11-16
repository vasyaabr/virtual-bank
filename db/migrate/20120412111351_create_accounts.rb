#encoding: utf-8
class CreateAccounts < ActiveRecord::Migration
  MORE_ACCOUNTS = [
    {:name => 'admin', :account => 'admin', :pass => '3366', :sum => 0, :credit => 0, :creditsum => 0, :mail => 'vasyaabr@gmail.com', :active => 1, :admin => 1},
    {:name => 'test', :account => 'test', :pass => 'test', :sum => 0, :credit => 0, :creditsum => 0, :mail => 'vasyaabr@gmail.com', :active => 1, :admin => 0},
    #{:name => '', :account => '', :pass => '', :sum => 000, :credit => 0, :creditsum => 0, :mail => '', :active => 1, :admin => 0},
  ]
  def up
    create_table :accounts do |t|
      t.string :name
      t.string :account
      t.string :pass
      t.integer :sum
      t.integer :credit
      t.integer :creditsum
      t.string :mail
      t.integer :active
      t.integer :admin
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
