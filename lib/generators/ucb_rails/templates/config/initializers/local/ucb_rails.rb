############################################################
# Load credentials from config/credentials.yml
############################################################

credentials_file = Rails.root.join('config/credentials.yml')
credentials = File.exists?(credentials_file) ? YAML.load_file(credentials_file) : {}

############################################################
# UCB::LDAP
############################################################

UCB::LDAP.host = 'nds.berkeley.edu'
ldap_credentials = credentials["ldap"] || credentials[Rails.env].try(:[], "ldap")
UCB::LDAP.authenticate(ldap_credentials['username'], ldap_credentials['password']) if ldap_credentials

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
