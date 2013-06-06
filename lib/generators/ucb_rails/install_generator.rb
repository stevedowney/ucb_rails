require 'rails/generators/active_record/migration'

module UcbRails
  # @private
  module Generators
    # @private
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      extend ActiveRecord::Generators::Migration
      source_root File.join(File.dirname(__FILE__), "templates")

      desc 'Copy ucb_rails files'
      class_option :readme, aliases: '-r', type: :boolean, desc: 'Display README and exit'
      
      def install
        return if options.readme?
        
        directory 'app/assets'
        directory 'app/helpers'
        directory 'app/views'
        directory 'config'
        install_migrations
      end

      def show_readme
        if behavior == :invoke
          readme "README"
        end
      end
      
      private
      
      def install_migrations
        template_dir = Pathname.new(self.class.source_root)
        Dir["#{template_dir}/db/migrate/*.rb"].each do |migration_file|
          # migration_template migration_file
          # puts migration_file
          relative_name = Pathname.new(migration_file).relative_path_from(Pathname.new(template_dir))
          migration_template relative_name
        end
      end
    end
  end
end