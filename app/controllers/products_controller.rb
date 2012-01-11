


require 'rubygems'
require 'rufus/scheduler'
require 'chronic'
require 'xmlrpc/client'






class ProductsController < ApplicationController
  # GET /products
  # GET /products.xml


  def get_geocode(address)
    logger.debug 'starting geocoder call for address: '+address
    # this is where we call the geocoding web service
    server = XMLRPC::Client.new2('http://rpc.geocoder.us/service/xmlrpc')
    result = server.call2('geocode', address)
    logger.debug "Geocode call: "+result.inspect

    return {:success=> true, :latitude=> result[1][0]['lat'],
		:longitude=> result[1][0]['long']}
  end


  def index
    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end

  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end





=begin
scheduler = Rufus::Scheduler.start_new
    scheduler.in ("10s")  do
    puts 'Current Time: '+ Time.zone.now.to_s
    @sellerNotificationMessage = "Your product is sold "

    Product.all.each do |check|
    @sellerToNotify      =  User.find(check.sellerid)
    puts ' check.expiry : ' + check.expiry.to_s + ' check.sellerid :' + check.sellerid.to_s ;
      if(Time.zone.now.to_i <= Time.zone.parse(check.expiry).to_i)
        puts 'expiry time is greater'


      else
        puts 'Current time is greater'
        @sellerToNotify.update_attributes!(:notification => @sellerNotificationMessage , :password=> '123456')
        puts 'Notification sent Successfully : ' + @sellerToNotify.email

        @rail= Bid.find_by_sql ["SELECT * FROM Bids WHERE itemid=?", check.id]
        if(@rail != nil && @rail != '')
          if(@rail.last != nil)
              @buyerToNotify = User.find(@rail.last.userid)
              puts ' The Bid winner : ' + @buyerToNotify.email
              @existingNotification = @buyerToNotify.notification
              @bidWinMessage = @existingNotification + "<br/><a href='http://localhost:3000/products/"+check.id.to_s+"'>"+check.Name+"</a>:Congrats! You are the Winner of the bid!"
              @buyerToNotify.update_attributes!(:notification => @bidWinMessage , :password=> '123456')
              puts 'Buyer has been successfully notified : ' + @buyerToNotify.email
           end
        end



      end
    end
    end

=end
  end



  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
    @user = current_user
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])
    tempAddress = @product.address+","+@product.city
    geocode = get_geocode tempAddress
    @product.forsale = 1
    @product.lat = geocode[:latitude]
    @product.lon = geocode[:longitude]
    @user = current_user
    @product.sellerid=@user.id
    @product.expiry=Chronic.parse(@product.expiry)

    respond_to do |format|
      if @product.save
        format.html { redirect_to(@product, :notice => 'Product was successfully created.') }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end


      puts ' Scheduler starting '
    scheduler = Rufus::Scheduler.start_new
    puts ' The product expiry has been scheduled in : '+ @product.expiry.to_s

    scheduler.at (@product.expirynew)  do

    puts 'Current Time: ' + Time.zone.now.to_s
        @sellerNotificationMessage = "<a href='http://localhost:3000/products/"+@product.id.to_s+"'>"+@product.Name+"</a>: Your product is sold"

     @sellerToNotify      =  User.find(@product.sellerid)
    puts ' @product.expiry : ' + @product.expiry.to_s + ' @product.sellerid :' + @product.sellerid.to_s ;

        @sellerToNotify.update_attributes!(:notification => @sellerNotificationMessage , :password=> '123456')
        puts 'Notification sent Successfully : ' + @sellerToNotify.email

        @rail= Bid.find_by_sql ["SELECT * FROM Bids WHERE itemid=?", @product.id]
        if(@rail != nil && @rail != '')
          if(@rail.last != nil)
              @buyerToNotify = User.find(@rail.last.userid)
              puts ' The Bid winner : ' + @buyerToNotify.email
              @existingNotification = @buyerToNotify.notification
               @bidWinMessage = "<a href='http://localhost:3000/products/"+@product.id.to_s+"'>"+@product.Name+"</a>:Congrats! You are the Winner of the bid!<br/>"+"<a href='http://localhost:3000/payment'>Click here</a> Use this ID "+@product.id.to_s+" to reserve your property" + @existingNotification
              @buyerToNotify.update_attributes!(:notification => @bidWinMessage , :password=> '123456')
              puts 'Buyer has been successfully notified : ' + @buyerToNotify.email
              @product.update_attribute(:forsale,0)
          end
        end
    end


  end

def ship
  @Notification = current_user.notification
  @newMessage = "<br/>"+" Use this number to track your Shipment: 19233456321101 <br/>"+@Notification
  current_user.update_attributes!(:notification => @newMessage , :password=> '123456')
   respond_to do |format|
      format.html { redirect_to profile_path }
      format.xml  { head :ok }
    end
end

  # PUT /products/1
  # PUT /products/1.xml
 def update

    @product = Product.find(params[:id])
    @sol = params[:forsale]
    @sellerToNotify      =  User.find(@product.sellerid)
    respond_to do |format|
      if @product.update_attribute(:forsale,0)
        # REDIRECT TO PAYMENT PAGE
        # format.html { redirect_to(@product, :notice => 'Product was successfully updated.') }
        @sellerNotificationMessage = "<a href='http://localhost:3000/products/"+@product.id.to_s+"'>"+@product.Name+"</a>: Your product is sold"
        @sellerToNotify.update_attributes!(:notification => @sellerNotificationMessage , :password=> '123456')
        format.html { redirect_to payment_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end
  def deliver
    @product = Product.find(params[:id])
    @rail= Bid.find_by_sql ["SELECT MAX(amount) FROM Bids WHERE itemid=?", @product.id]
    id = @product.sellerid

    @user = User.find(id)
    @NotificationMessage = "Your product has been sold "+"<a href='http://localhost:3000/products/"+@product.id.to_s+"'>"+@product.Name+"</a>"
    @user.update_attributes!(:notification => @NotificationMessage , :password=> '123456')


  end

  def next_for_delivery
    @product = Product.find(1);
  end
end
