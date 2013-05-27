class UcbRails::SessionsController < ApplicationController
  
  skip_before_filter :ensure_authenticated_user

  def new
    provider = params.fetch(:provider, :cas)
    redirect_to "/auth/#{provider}"
  end

  def create
    session[:uid] = request.env['omniauth.auth'].uid
    session[:provider] = request.env['omniauth.auth'].provider
    # UserSessionManager.login(session[:uid])
    redirect_to session[:original_url] || root_path
  end
   
  def destroy
    # UserSessionManager.logout(current_user)
    provider = session[:provider]
    reset_session
    redirect_to redirect_url(provider)
  end
  
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