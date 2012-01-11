class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end

  def create
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'
    else
      sign_in user
      redirect_to user
    end
    current_user = user
  end

  def destroy
    sign_out
    redirect_to signin_path
  end

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
    @visit = self.current_user.visit;
    if @visit.nil?
      @visit = 1;
    end
    self.current_user.update_attributes!(:password=> '123456',:visit=> @visit+1)
    # redirect_to home_path
  end

  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end

end
