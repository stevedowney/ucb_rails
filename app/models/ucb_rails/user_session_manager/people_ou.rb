module UcbRails
  module UserSessionManager
    class PeopleOu < Base
      
      def login(uid)
        self.uid = uid
        
        if people_ou_entry
          OpenStruct.new(uid: uid)
        else
          false
        end
      end
      
      def current_user(uid)
        OpenStruct.new(uid: uid)
      end
      
    end
  end
end