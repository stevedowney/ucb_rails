module UcbRails
  module Configuration
  
  # Manage configuration from file.  Per environment or overall.
  #
  # @example
  #   # config/config.yml
  #   test:
  #     ldap:
  #       username: test_username
  #       password: test_password
  # 
  #   ldap:
  #     username: top_username
  #     password: top_password
  #
  #   # in config/initializers/ucb_rails.rb  (e.g.)
  #   config = UcbRails::Credentials.new
  #   
  #   # in production -- pulls from top level, since no 'production' key
  #   config.for('ldap') #=> { 'username' => 'top_username', 'password' => 'top_password' }
  #
  #   # in test -- pulls from 'test' key
  #   config.for('ldap') #=> { 'username' => 'test_username', 'password' => 'test_password' }
  class Configuration
    FileNotFound = Class.new(StandardError)
    KeyNotFound = Class.new(StandardError)
    
    attr_accessor :config_filename, :config_yaml
    
    def initialize(filename=Rails.root.join('config/config.yml'))
      self.config_filename = filename.to_s
      load_file
    end
    
    # Return configuration value for _key_.
    # @param key [String]
    def for(key)
      from_environment(key) || from_top_level(key)
    end
    
    # Return configuration value for _key_.
    # @raise [UcbRails::Configuration::KeyNotFound] if _key_ not in configuration file.
    def for!(key)
      self.for(key) or raise(KeyNotFound, key.inspect)
    end
    
    private
    
    def from_environment(key)
      environmet_value && environmet_value[key]
    end

    def from_top_level(key)
      config_yaml[key]
    end
    
    def environmet_value
      config_yaml[RailsEnvironment.rails_env]
    end
    
    def load_file
      if File.exists?(config_filename) 
        self.config_yaml = YAML.load_file(config_filename)
      else
        raise(FileNotFound, config_filename)
      end
    end
  end
  
end
end