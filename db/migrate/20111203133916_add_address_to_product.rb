class AddAddressToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :address, :string
  end

  def self.down
    remove_column :products, :address
  end
end
