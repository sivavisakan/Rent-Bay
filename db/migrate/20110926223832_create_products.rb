class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :Name
      t.string :Category
      t.decimal :Price, :precision => 8, :scale => 2
      t.text :Rental_Period
      t.string :Upload_Picture
      t.text :Description

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
