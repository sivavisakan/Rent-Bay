class AddTermsToProduct < ActiveRecord::Migration
  def self.up
    add_column :products, :terms, :string
  end

  def self.down
    remove_column :products, :terms
  end
end
