class UcbRails::BootstrapController < ApplicationController
  
  def index
    if RailsEnvironment.not_development?
      raise ActionController::RoutingError, "No route matches [#{env['REQUEST_METHOD']}] #{env['PATH_INFO'].inspect}"
    end

    if UcbRails::User.count > 0
      return render_text("Can't bootstrap.  Already have users.")
    end
    
    if uid.present?
      UCB::LDAP::Person.find_by_uid(uid).tap do |e|
        return render_text("Bad uid: #{uid.inspect}") if e.blank?
        UcbRails::UserLdapService.create_user(uid)
        redirect_to login_path
      end
    else
      return render_text "Must provide a uid: /ucb_rails/bootstrap/:uid"
    end
  end
  
  private
  
  def uid
    params[:uid]
  end
  
  def render_text(text)
    render text: text
  end
end