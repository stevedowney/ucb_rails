module UcbRails
  module UserSessionManager

    class InPeopleOuAddToUsersTable < ActiveInUserTable
      
      def login(uid)
        self.uid = uid
        
        if people_ou_entry.present?
          UcbRails::UserLdapService.create_or_update_user_from_entry(people_ou_entry)
        else
          nil
        end
      end
      
    end

  end
end