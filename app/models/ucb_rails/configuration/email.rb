module UcbRails
  module Configuration
    class Email
      ArgumentError = Class.new(StandardError)

      attr_accessor :hash

      def self.configure(config)
        new(config)
      end
      
      def initialize(configuration_hash)
        return if configuration_hash.nil?
        raise(ArgumentError, "expected a Hash, got: #{configuration_hash.inspect}") unless configuration_hash.is_a?(Hash)
        
        self.hash = configuration_hash
        process_configuration
      end

      private

      def process_configuration
        process_default
        process_delivery_method
        process_default_url_options
        process_raise_delivery_errors
        process_sendmail_settings
        process_smtp_settings
        process_subject_prefix
      end

      # This merges values with existing values
      def process_default
        if hash.has_key?('default')
          ActionMailer::Base.default hash['default']
        end
      end

      def process_delivery_method
        ActionMailer::Base.delivery_method = hash.fetch('delivery_method', :smtp).to_sym
      end

      def process_default_url_options
        if hash.has_key?('default_url_options')
          ActionMailer::Base.default_url_options = hash.fetch('default_url_options')
        end
      end

      def process_raise_delivery_errors
        ActionMailer::Base.raise_delivery_errors = hash.fetch('raise_delivery_errors', true)
      end

      def process_sendmail_settings
        if hash.has_key?('sendmail_settings')
          ActionMailer::Base.sendmail_settings = hash.fetch('sendmail_settings').symbolize_keys
        end
      end

      def process_smtp_settings
        if hash.has_key?('smtp_settings')
          ActionMailer::Base.smtp_settings = hash.fetch('smtp_settings').symbolize_keys
        end
      end

      def process_subject_prefix
        prefix = hash.fetch('subject_prefix', '')
        prefix = prefix.gsub("{env}", RailsEnvironment.short)
        UcbRails.config.email_subject_prefix = prefix
      end
    end

  end
end