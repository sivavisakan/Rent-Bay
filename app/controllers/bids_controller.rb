require 'rubygems'
require 'rufus/scheduler'



class BidsController < ApplicationController
 scheduler = Rufus::Scheduler.start_new



  def new
    @bid = Bid.new
  end







  def create


    @bid = Bid.new(params[:bid])

    @bid.userid=current_user.id
    @current_product = @bid.itemid
    @rail= Bid.find_by_sql ["SELECT * FROM Bids WHERE itemid=?", @current_product]
    @product =  Product.find_by_sql ["SELECT * FROM Products WHERE id=?",@current_product]

    if(@rail.last == nil)
    @maxVal = @product.last.Price
    @userNotify = nil
    else
    @maxVal = "#{@rail.last.amount}".to_f
    @userNotify = @rail.last.userid
    end

    if (@bid.amount > @maxVal)

      if(@userNotify != nil)
      @userToNotify =  User.find_by_sql ["SELECT * FROM Users WHERE id=?",@userNotify]

      @NotificationMessage = "<a href='http://localhost:3000/products/"+@product.last.id.to_s+"'>"+@product.last.Name+"</a>: A higher bid has been placed!"
      @userToNotify.last.update_attributes!(:notification => @NotificationMessage , :password=> '123456')
      end


   # respond_to do |format|
      if @bid.save
         redirect_to showitem_path  :id => @current_product,:notice => "You have Successfully bid on the item"
        # format.html { redirect_to :url => {:view => "products", :action => "show"}
         # format.html { redirect_to(@product, :notice => 'Product was successfully created.') }
        #format.xml  { render :xml => @product, :status => :created, :location => @product }
        # format.html { redirect_to product_path }
      else
        redirect_to showitem_path  :id => @current_product
        #format.html { render :action => "new" }
        #format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end

     else
          redirect_to showitem_path  :id => @current_product,:notice => "You have Successfully bid on the item"

     end
    end

end
