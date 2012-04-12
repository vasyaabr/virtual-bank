class CreateAccounts < ActiveRecord::Migration
  MORE_ACCOUNTS = [
    {:name => 'Basil', :account => '9211147767', :pass => '666', :sum => 0, :credit => 1},
  ]
  def up
    create_table :accounts do |t|
      t.string :name
      t.string :account
      t.string :pass
      t.integer :sum
      t.integer :credit
    end
#    MORE_ACCOUNTS.each do |acc|
#      Account.create!(acc)
  end

  def down
    drop_table :accounts
  end
end
