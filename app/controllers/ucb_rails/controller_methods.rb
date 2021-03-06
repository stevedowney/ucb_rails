# Various controller methods mixed in to the host app.
# 
# Most are also helper methods.
module UcbRails::ControllerMethods
  extend ActiveSupport::Concern

  included do
    rescue_from UcbRails::LdapPerson::Finder::BlankSearchTermsError do
      render :js => %(alert("Enter search terms"))
    end

    before_filter :ensure_authenticated_user
    before_filter :log_request
    
    after_filter  :remove_user_settings
    
    helper_method :admin?, :current_ldap_person, :current_user, :logged_in?
  end

  def admin?
    current_user.try(:admin?)
  end  

  def current_user
    @current_user ||= begin
      UcbRails.logger.debug 'recalc of current_user'
      user_session_manager.current_user(session[:uid])
    end
  end
  
  # Returns +true+ if there is a logged in user
  #
  # @return [true] if user logged in
  # @return [false] if user not logged in
  def logged_in?
    current_user.present?
  end
  
  def log_request
    UcbRails::UserSessionManager::Base.current_user = current_user
    user_session_manager.log_request(current_user)
  end
  
  def remove_user_settings
    UcbRails::UserSessionManager::Base.current_user = nil
  end
  
  # Returns an instance of UCB::LDAP::Person if there is a logged in user
  #
  # @return [UCB::LDAP::Person] if user logged in
  # @return [nil] if user not logged in
  def current_ldap_person
    if logged_in?
      @current_ldap_person ||= begin
        UcbRails.logger.debug 'recalc of current_ldap_person'
        user_session_manager.people_ou_entry(session[:uid])
      end
    end
  end

  def ensure_admin_user
    admin? or redirect_to not_authorized_path
  end
  
  # Before filter that redirects redirects to +login_url+ unless user is logged in
  #
  # @return [nil]
  def ensure_authenticated_user
    unless session.has_key?(:uid)
      session[:original_url] = request.env['REQUEST_URI']
      redirect_to login_url
    end
  end

  def user_session_manager
    @user_session_manager ||= begin
      UcbRails.logger.debug "creating new user_session_manager"
      klass = UcbRails[:user_session_manager] || UcbRails::UserSessionManager::ActiveInUserTable
      klass.to_s.classify.constantize.new
    end
  rescue NameError
    raise "Could not find UcbRails user_session_manager: #{klass}"
  end
  
end