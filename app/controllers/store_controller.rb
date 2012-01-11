class StoreController < ApplicationController
  def index
    @products = Product.all
  end

  def allProducts
    @products = Product.all
  end
end
