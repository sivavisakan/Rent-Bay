

class ApplicationController < ActionController::Base
before_filter :set_user_time_zone
  protect_from_forgery
  include SessionsHelper
   private
  def set_user_time_zone
    Time.zone = 'EST'
  end
end
