# Various controller methods mixed in to the host app.
# 
# Most are also helper methods.
module UcbRails::ControllerMethods
  
  extend ActiveSupport::Concern

    included do
      helper_method :current_ldap_person, :logged_in?
    end

  # Returns +true+ if there is a logged in user
  #
  # @return [true] if user logged in
  # @return [false] if user not logged in
  def logged_in?
    session[:uid].present?
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

end