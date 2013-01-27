class HomeController < ApplicationController
  protect_from_forgery

  def index
  	if user_signed_in?
  		render :template => 'home/dashboard'
  	else
  		render :template => 'home/index'
  	end
  end
end
