class CreateTransactions < ActiveRecord::Migration
  def up
    create_table :transactions do |t|
      t.string :from
      t.string :to
      t.datetime :change_date
      t.integer :sum
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end

  def down
    drop_table :transactions
  end
end
