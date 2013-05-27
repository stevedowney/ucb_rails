require 'rails/generators/active_record/migration'

module UcbRails
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      extend ActiveRecord::Generators::Migration
      source_root File.join(File.dirname(__FILE__), "templates")

      def self.initializer_path; 'config/initializers/local_vendor/ucb_rails.rb';end
      
      desc <<DESC
Description:
    # Copies stylesheet    to 'app/assets/stylesheets/user_announcements.css'
    Copies configuration
    # Copies db migration  to 'db/migrate/<timestamp>/create_user_announcement_tables.rb'
    
DESC
  
      def preamble
        puts "\n============================================================"
        puts "Installing UCB Rails Essentials\n"
      end
      
      def install
        # copy_file "template.css", 'app/assets/stylesheets/user_announcements.css'
        copy_file "initializer.rb", 'config/initializers/local_vendor/ucb_rails.rb'
        # migration_template "migration.rb", "db/migrate/create_user_announcement_tables.rb"
      end

      def postscript
        puts %(
Installation complete:
  * review settings in the intializer
)
        puts "============================================================\n\n"
      end
    end
  end
end