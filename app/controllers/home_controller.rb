class HomeController < ApplicationController
  protect_from_forgery

  def index
  	if user_signed_in?
  		@devices = Device.where(:user_id => current_user[:id])
  		render :template => 'home/dashboard'
  	else
  		render :template => 'home/index'
  	end
  end
end
