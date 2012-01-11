class AddVisitToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :visit, :integer
  end

  def self.down
    remove_column :users, :visit
  end
end
