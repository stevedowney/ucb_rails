module UcbRails
  
  # @private
  class Engine < ::Rails::Engine
    config.generators.integration_tool :rspec
    config.generators.test_framework :rspec
    
    initializer 'ucb_rails.app_controller' do |app|
      ActiveSupport.on_load(:action_controller) do
        include UcbRails::ControllerMethods
      end
    end 
  end
  
  def self.config(&block)
    yield Engine.config if block
    Engine.config
  end
  
  def self.[](key)
    setting = config.send(key)
    
    if setting.is_a?(Proc)
      setting.call
    else
      setting
    end
    
  rescue NameError
    Rails.logger.debug "[UcbRails] Tried to access unknown UcbRails.config key: #{key.inspect}"
    nil
  end
  
end
