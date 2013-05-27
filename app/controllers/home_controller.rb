class HomeController < ApplicationController
  
  def index
    if logged_in?
      render 'logged_in'
    else
      render 'not_logged_in'
    end
  end
  
end