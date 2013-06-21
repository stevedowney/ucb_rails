module UcbRails
  module Configuration
    
    class ExceptionNotification
      
      class << self
        
        def configure(config)
          return if config.blank?
          
          config = config.symbolize_keys
          config[:email].symbolize_keys!
          config[:email][:email_prefix] = config[:email][:email_prefix].gsub("{env}", RailsEnvironment.short)
          
          Rails.application.config.middleware.use ::ExceptionNotification::Rack, config
        end
      end
    end
    
  end
end