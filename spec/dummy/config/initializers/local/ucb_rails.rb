

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(:developer, fields: [:uid], uid_field: :uid) unless Rails.env.production?
  
  cas_host = RailsEnvironment.production? ? 'auth.berkeley.edu/cas' : 'auth-test.berkeley.edu/cas'
  provider :cas, host: cas_host
end