class AddCityToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :city, :string
  end

  def self.down
    remove_column :products, :city
  end
end
