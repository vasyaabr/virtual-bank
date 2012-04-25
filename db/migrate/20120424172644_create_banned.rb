class CreateBanned < ActiveRecord::Migration
  def up
    create_table :bans do |t|
      t.string :ip
      t.integer :try
      t.datetime :banned_till
      # Add fields that let Rails automatically keep track
      # of when movies are added or modified:
      t.timestamps
    end
  end

  def down
    drop_table :bans
  end
end
