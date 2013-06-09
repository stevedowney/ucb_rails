module UcbRails
  module UserSessionManager
    class InPeopleOu < Base
      
      def login(uid)
        self.uid = uid
        
        if people_ou_entry.present?
          current_user(uid)
        else
          false
        end
      end
      
      def current_user(uid)
        self.uid = uid
        
        if people_ou_entry.present?
          ldap_person_user_wrapper(people_ou_entry)
        else
          nil
        end
      end
      
    end
  end
end