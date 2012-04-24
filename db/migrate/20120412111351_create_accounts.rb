#encoding: utf-8
class CreateAccounts < ActiveRecord::Migration
  MORE_ACCOUNTS = [
    {:name => 'Лукомир', :account => '111666', :pass => '3366', :sum => 12000, :credit => 0, :creditsum => 0, :mail => 'vasyaabr@gmail.com', :active => 1, :admin => 1},
    {:name => 'Серж де Гил', :account => '222444', :pass => '5193', :sum => 7500, :credit => 0, :creditsum => 0, :mail => 't-pskov_m@rambler.ru', :active => 1, :admin => 1},
    {:name => 'Барон Святояр', :account => '111000', :pass => '1141', :sum => 20000, :credit => 0, :creditsum => 0, :mail => 'rt-567@yandex.ru', :active => 1, :admin => 0},
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
