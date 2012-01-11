class AddLonToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :lon, :string
  end

  def self.down
    remove_column :products, :lon
  end
end
