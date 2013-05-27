Rails.application.config.middleware.use OmniAuth::Builder do
  provider(:developer, fields: [:uid], uid_field: :uid) unless Rails.env.production?
  provider :cas, host: 'auth.berkeley.edu/cas'
end