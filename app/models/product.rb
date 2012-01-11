# == Schema Information
#
# Table name: products
#
#  id             :integer         not null, primary key
#  Name           :string(255)
#  Category       :string(255)
#  Price          :decimal(8, 2)
#  Rental_Period  :text
#  Upload_Picture :string(255)
#  Description    :text
#  created_at     :datetime
#  updated_at     :datetime
#

class Product < ActiveRecord::Base

  has_many :bids
  default_scope :order => 'Name'
  has_attached_file :avatar,
end
