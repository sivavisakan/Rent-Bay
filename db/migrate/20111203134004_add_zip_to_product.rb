class AddZipToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :zip, :string
  end

  def self.down
    remove_column :products, :zip
  end
end
