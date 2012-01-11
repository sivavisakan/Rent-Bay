class AddExpiryToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :expiry, :string
  end

  def self.down
    remove_column :products, :expiry
  end
end
