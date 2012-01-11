class AddForsaleToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :forsale, :int
  end

  def self.down
    remove_column :products, :forsale
  end
end
