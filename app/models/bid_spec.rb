require 'spec_helper'

describe Bid do

  before(:each) do
    @attr = {
      :amount => 100,
      :userid => 1,
      :itemid => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Bid.create!(@attr)
  end
end
