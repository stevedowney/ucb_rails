module UcbRails
  module UserSessionManager

    class LdapPersonUserWrapper
      attr_accessor :ldap_person_entry
      
      def initialize(ldap_person_entry)
        self.ldap_person_entry = ldap_person_entry
      end
      
      def id
        uid
      end
      
      def admin?
        false
      end
      
      def method_missing(method, *args, &block)
        if ldap_person_entry.respond_to?(method)
          ldap_person_entry.send(method, *args, &block)
        else
          super
        end
      end
    end
    
  end
end