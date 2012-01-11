class AddDobToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :dob, :string
  end

  def self.down
    remove_column :users, :dob
  end
end
