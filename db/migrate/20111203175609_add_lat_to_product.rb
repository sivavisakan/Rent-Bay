class AddLatToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :lat, :string
  end

  def self.down
    remove_column :products, :lat
  end
end
