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

UcbRails::Configuration::Ldap.configure(config.for('ldap'))

############################################################
# OmniAuth
############################################################

UcbRails::Configuration::Cas.configure(config.for('cas'))

############################################################
# UcbRails
############################################################

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
