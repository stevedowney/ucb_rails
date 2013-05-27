module UcbRails
  class Engine < ::Rails::Engine
    
    initializer 'ucb_rails.app_controller' do |app|
      ActiveSupport.on_load(:action_controller) do
        # extend MyModule::ClassMethods
        include UcbRails::ControllerMethods
      end
    end
    
  end
end
