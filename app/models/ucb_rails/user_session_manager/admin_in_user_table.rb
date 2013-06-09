module UcbRails
  module UserSessionManager
    class AdminInUserTable < ActiveInUserTable

      private
      
      def user_table_entry
        active_admin_user
      end
      
    end
  end
end