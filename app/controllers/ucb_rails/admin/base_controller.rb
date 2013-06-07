class UcbRails::Admin::BaseController < ApplicationController
  before_filter :ensure_admin_user
  
end