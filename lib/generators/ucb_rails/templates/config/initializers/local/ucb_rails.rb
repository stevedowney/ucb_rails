############################################################
# Load configuration from config/config.yml
############################################################

config = UcbRails::Configuration::Configuration.new

############################################################
# ActionMailer
############################################################

UcbRails::Configuration::Email.configure(config.for('email'))

############################################################
# Exception Notification
############################################################

UcbRails::Configuration::ExceptionNotification.configure(config.for('exception_notification'))

############################################################
# UCB::LDAP
############################################################

UCB::LDAP.host = 'nds.berkeley.edu'
if ldap_credentials = config.for('ldap')
  puts "[UcbRails] Using ldap credentials from #{config.config_filename}"
  UCB::LDAP.authenticate(ldap_credentials['username'], ldap_credentials['password'])
else
  puts "[UcbRails] No ldap credentials found.  Using anonymous bind."
end
  
############################################################
# OmniAuth
############################################################

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(:developer, fields: [:uid], uid_field: :uid) unless RailsEnvironment.production?
  
  cas_host = RailsEnvironment.production? ? 'auth.berkeley.edu/cas' : 'auth-test.berkeley.edu/cas'
  provider :cas, host: cas_host
end

UcbRails.config do |config|
  
  #########################################################
  # manage login authorization, current user, etc.
  #########################################################

  # config.user_session_manager = "UcbRails::UserSessionManager::InPeopleOu"
  # config.user_session_manager = "UcbRails::UserSessionManager::InPeopleOuAddToUsersTable"
  config.user_session_manager = "UcbRails::UserSessionManager::ActiveInUserTable"
  # config.user_session_manager = "UcbRails::UserSessionManager::AdminInUserTable"
  
  #########################################################
  # omniauth authentication provider
  #########################################################

  config.omniauth_provider = :cas        # goes to CalNet
  # config.omniauth_provider = :developer  # Users test ldap entries
  
end
