# Various controller methods mixed in to the host app.
# 
# Most are also helper methods.
module UcbRails::ControllerMethods
  extend ActiveSupport::Concern

  included do
    before_filter :ensure_authenticated_user
    before_filter :log_request
    
    after_filter  :remove_user_settings
    
    helper_method :admin?, :current_ldap_person, :current_user, :logged_in?
  end

  def admin?
    current_user.try(:admin?)
  end  

  def current_user
    @current_user ||= UcbRails::User.find_by_uid(session[:uid]) if session[:uid].present?
  end
  
  # Returns +true+ if there is a logged in user
  #
  # @return [true] if user logged in
  # @return [false] if user not logged in
  def logged_in?
    current_user.present?
  end
  
  def log_request
    UcbRails::UserSessionManager.log_request(current_user)
    UcbRails::UserSessionManager.current_user = current_user
  end
  
  def remove_user_settings
    UcbRails::UserSessionManager.current_user = nil
  end
  
  # Returns an instance of UCB::LDAP::Person if there is a logged in user
  #
  # @return [UCB::LDAP::Person] if user logged in
  # @return [nil] if user not logged in
  def current_ldap_person
    if logged_in?
      UCB::LDAP::Person.find_by_uid(session[:uid])
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

end