module UcbRails
  module Configuration
    
    class Ldap
      attr_accessor :config
      
      def initialize(config)
        self.config = config.presence || {}
      end
      
      def configure
        configure_host
        authenticate
      end
      
      private

      def configure_host
        UCB::LDAP.host = config.fetch('host', default_host)
      end

      def authenticate
        if config.has_key?('username')
          UCB::LDAP.authenticate config['username'], config['password']
        end
      end

      def default_host
        RailsEnvironment.production? ? 'nds.berkeley.edu' : 'nds-test.berkeley.edu'
      end

      class << self
        def configure(config)
          new(config).configure
        end
      end
    end
    
  end
end