class AddNotificationToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :notification, :string
  end

  def self.down
    remove_column :users, :notification
  end
end
