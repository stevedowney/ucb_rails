class UcbRails::HomeController < ApplicationController
  
  # Renders either a "logged in" page or a "logged out" page.
  # Mainly used for getting going with the +ucb_rails+ gem.  
  # Not intended for production use.
  #
  # @return [nil]
  def index
    if logged_in?
      render 'logged_in'
    else
      render 'not_logged_in'
    end
  end
  
end