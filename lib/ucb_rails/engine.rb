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
end
