module UcbRails
  
  # Manage credentials from file.  Per environment or overall.
  #
  # @example
  #   # config/credentials.yml
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
  #   credentials = UcbRails::Credentials.new
  #   
  #   # in production -- pulls from top level, since no 'production' key
  #   credentials.for('ldap') #=> { 'username' => 'top_username', 'password' => 'top_password' }
  #
  #   # in test -- pulls from 'test' key
  #   credentials.for('ldap') #=> { 'username' => 'test_username', 'password' => 'test_password' }
  class Credentials
    FileNotFound = Class.new(StandardError)
    KeyNotFound = Class.new(StandardError)
    
    attr_accessor :credentials_filename, :credentials_yaml
    
    def initialize(filename=Rails.root.join('config/credentials.yml'))
      self.credentials_filename = filename.to_s
      load_file
    end
    
    def for(key, options={})
      from_environment(key) ||
      from_top_level(key) ||
      not_found(key, options[:allow_nil])
    end
    
    private
    
    def from_environment(key)
      environmet_value && environmet_value[key]
    end

    def from_top_level(key)
      credentials_yaml[key]
    end
    
    def environmet_value
      credentials_yaml[RailsEnvironment.rails_env]
    end
    
    def not_found(key, allow_nil)
      return nil if allow_nil
      raise(KeyNotFound, key.inspect)
    end
    
    def load_file
      if File.exists?(credentials_filename) 
        self.credentials_yaml = YAML.load_file(credentials_filename)
      else
        UcbRails.logger.error "Did not find credentials file: #{credentials_filename.inspect}"
        UcbRails.logger.error "You can: cp config/credentials.yml.example config/credentials.yml"
        raise(FileNotFound, credentials_filename)
      end
    end
  end
  
end