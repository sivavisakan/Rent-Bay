class Bid < ActiveRecord::Base
  attr_accessible :itemid, :userid, :value, :amount
  belongs_to :product
end
