class UcbRails::Admin::BaseController < ApplicationController
  
  def index
    @users = UcbRails::User.all
  end
  
end