module UcbRails
  module Configuration
    
    class Cas
      attr_accessor :config
      
      def initialize(config)
        self.config = config.presence || {}
      end
      
      def configure
        configure_omniauth
        set_ucb_rails_cas_host
      end
      
      def configure_omniauth
        host_name = host
        Rails.application.config.middleware.use OmniAuth::Builder do
          
          unless RailsEnvironment.production?
            provider(:developer, fields: [:uid], uid_field: :uid)
          end
          
          provider :cas,
            host: host_name,
            login_url: '/cas/login',
            service_validate_url: '/cas/serviceValidate'
        end
      end
      
      def set_ucb_rails_cas_host
        UcbRails.config.cas_host = host
      end
      
      private

      def host
        config.fetch('host', default_host)
      end
      
      def default_host
        RailsEnvironment.production? ? 'auth.berkeley.edu' : 'auth-test.berkeley.edu'
      end
      
      class << self
        def configure(config)
          new(config).configure
        end
      end
    end
    
  end
end