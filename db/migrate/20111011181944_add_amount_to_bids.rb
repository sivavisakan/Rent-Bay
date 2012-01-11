class AddAmountToBids < ActiveRecord::Migration
  def self.up
    add_column :bids, :amount, :float
  end

  def self.down
    remove_column :bids, :amount
  end
end
