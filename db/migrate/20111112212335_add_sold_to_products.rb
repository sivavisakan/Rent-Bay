class AddSoldToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :sold, :boolean
  end

  def self.down
    remove_column :products, :sold
  end
end
