class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end


  def show
    @user = current_user
  end


  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
   end

  def new
    @user = User.new
    @title = "Sign up"
  end

  def create
    @user = User.new(params[:user])
    @user.usertype = 1;
    @user.active = 1;
    @user.visit = 0;
    @user.notification = "Hello"
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end

  def upgrade
    @user = current_user


  end


 def update
    @user = User.find(params[:id])
    @val = @user.usertype
    password1 = current_user.password
    respond_to do |format|
      if @user.update_attributes!(:usertype=>'3',:password=> '123456' )

       format.html { render :action => "show" }
      #  format.xml  { head :ok }

      else

       format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
 end

def edit
   @user = User.find(params[:id])
end

def allusers
    @all = Bid.find_by_sql ["SELECT * FROM Users"]
    @maxValue = "#{@rail.last.amount}".to_f
    format.html { redirect_to(@user, :notice => 'Account was successfully upgraded.') }
end

def destroy
    @user = User.find(params[:id])

    if @user.active == 0
    @user.update_attributes!(:active => '1',:password => '123456')
    else
      @user.update_attributes!(:active => '0',:password => '123456')
      @allbids = Bid.find_by_sql ["DELETE FROM Bids where userid=?", @user]
    end



    respond_to do |format|
    format.html { redirect_to(allusers_url) }

    end
end
  def reports
    @res = nil
    lookup = params[:lookup]
        if(lookup != nil && lookup != '')
          @res = User.find(lookup)
        end
    @totalActive  = User.where(:active => 1).count
    @totalBlocked = User.where(:active => 0).count
    @totalSellers     = User.where(:active => 1,:usertype => [2,3,4]).count
    @totalBuyers      = User.where(:active => 1,:usertype => 1).count

    @churnCount       = 0
    @user = User.all
    @user.each do |user|
      seconds  = Time.now - user.updated_at
      if(seconds > 259200)
        @churnCount += 1
      end
    end
    @totalActiveProducts = Product.where(:forsale => 1).count
    @totalSoldProducts = Product.where(:forsale => 0).count
    @totalMoney = Product.where(:forsale => 0).sum(:Price)

  end



=begin
def reports
    lookup = params[:lookup]
    if(lookup!=nil)
      @us =  User.find(lookup)
      respond_to do |format|
        format.html { redirect_to(allusers_url) }
      end
    end
  end
=end

end
