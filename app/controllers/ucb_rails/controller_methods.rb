module UcbRails::ControllerMethods
  
  extend ActiveSupport::Concern

    included do
      helper_method :current_ldap_person, :logged_in?
    end

  def logged_in?
    session[:uid].present?
  end
  
  def current_ldap_person
    if logged_in?
      UCB::LDAP::Person.find_by_uid(session[:uid])
    end
  end

  module ClassMethods
  end
  
end