class AddSelleridToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :sellerid, :integer
  end

  def self.down
    remove_column :products, :sellerid
  end
end
