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
      
      def install
        directory 'app/assets'
        directory 'app/views'
        directory 'config'
      end

    end
  end
end