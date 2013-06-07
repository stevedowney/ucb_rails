# Manages starting and ending of sessions, i.e., logging in and out.
class UcbRails::SessionsController < ApplicationController
  
  skip_before_filter :ensure_authenticated_user

  # Redirects to authentication provider
  #
  # @return [nil]
  def new
    provider = params.fetch(:provider, :cas)
    redirect_to "/auth/#{provider}"
  end

  # Login user after authentication by provider
  #
  # @return [nil] 
  def create
    uid = request.env['omniauth.auth'].uid
    session[:provider] = request.env['omniauth.auth'].provider
    
    if session_manager.login(uid)
      session[:uid] = uid
      redirect_to session[:original_url] || root_path
    else
      redirect_to not_authorized_path
    end
  end
   
  # Log user out 
  #
  # @return [nil]
  def destroy
    session_manager.logout(current_user)
    provider = session[:provider]
    reset_session
    redirect_to redirect_url(provider)
  end
  
  def not_authorized
    render(:text => "Not Authorized", :status => 401)
  end

  # Handler for authentication failure.
  #
  # @return [nil]
  def failure
    Rails.logger.debug("Authentication Failed for: #{request.env['omniauth.auth']}")
    render(:text => "Not Authorized", :status => 401)
  end
  
  private
  
  def redirect_url(provider)
    if provider.to_s == 'cas'
      "http://auth.berkeley.edu/cas/logout?url=#{root_url}"
    else
      root_path
    end
  end
  
  
end