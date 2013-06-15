require "ucb_rails/engine"
require 'ucb_rails/log_tagger'

require 'haml'
require 'haml-rails'
require 'kaminari'
require 'omniauth'
require 'omniauth-cas'
require 'sass-rails'
require 'bootstrap-sass'
require 'active_attr'
require 'simple_form'
require 'jquery-datatables-rails'

require 'rails_environment'
require 'ucb_ldap'
require 'bootstrap-view-helpers'
require 'rails_view_helpers'
require 'user_announcements'
  
module UcbRails
  
  def self.logger
    @logger ||= LogTagger.new('UcbRails', Rails.logger)
  end
  
end
