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
        test_entries
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
      
      def test_entries
        UCB::LDAP::Person.include_test_entries = config.fetch('include_test_entries', default_include_test_entries)
      end
      
      def default_host
        RailsEnvironment.production? ? 'nds.berkeley.edu' : 'nds-test.berkeley.edu'
      end

      def default_include_test_entries
        RailsEnvironment.not_production?
      end
      
      class << self
        def configure(config)
          new(config).configure
        end
      end
    end
    
  end
end