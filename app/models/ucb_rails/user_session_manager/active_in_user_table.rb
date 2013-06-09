module UcbRails
  module UserSessionManager
    class ActiveInUserTable < Base

      def login(uid)
        self.uid = uid
        
        if user_table_entry && people_ou_entry
          UcbRails::UserLdapService.update_user_from_ldap_entry(people_ou_entry).tap do |user|
            user.touch(:last_login_at)
          end
        else
          false
        end
      end
      
      def current_user(uid)
        UcbRails::User.find_by_uid(uid)
      end

      def log_request(user)
        user.present? and user.touch(:last_request_at)
      end

      def logout(user)
        user.present? and user.touch(:last_logout_at)
      end
      
      private
      
      def user_table_entry
        active_user
      end

    end
  end
end