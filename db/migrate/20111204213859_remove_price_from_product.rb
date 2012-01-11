class RemovePriceFromProduct < ActiveRecord::Migration
  def self.up
    remove_column :products, :Price
  end

  def self.down
    add_column :products, :Price, :decimal
  end
end
