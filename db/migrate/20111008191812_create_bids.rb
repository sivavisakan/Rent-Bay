class CreateBids < ActiveRecord::Migration
  def self.up
    create_table :bids do |t|
      t.integer :userid
      t.integer :itemid
      t.float :value

      t.timestamps
    end
  end

  def self.down
    drop_table :bids
  end
end
