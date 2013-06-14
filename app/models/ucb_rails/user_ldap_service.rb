class UcbRails::UserLdapService
  
  class << self
    
    def create_user_from_uid(uid)
      ldap_entry = UcbRails::LdapPerson::Finder.find_by_uid!(uid)
      create_user_from_ldap_entry(ldap_entry)
    end
    
    def create_user_from_ldap_entry(ldap_entry)
      
      UcbRails::User.create! do |u|
        u.uid = ldap_entry.uid
        u.first_name = ldap_entry.first_name
        u.last_name = ldap_entry.last_name
        u.email = ldap_entry.email
        u.phone = ldap_entry.phone
        
      end
      
    end
    
    def update_user_from_ldap_entry(ldap_entry)
      # ldap_entry = UcbRails::LdapPerson::Finder.find_by_uid!(uid)
      UcbRails::User.find_by_uid!(ldap_entry.uid).tap do |user|
        user.first_name = ldap_entry.first_name
        user.last_name = ldap_entry.last_name
        user.email = ldap_entry.email
        user.phone = ldap_entry.phone
        user.save(validate: false)
      end
    end
    
    def create_or_update_user(uid)
      if user = UcbRails::User.find_by_uid(uid)
        update_user(uid)
      else
        create_user(uid)
      end
    end
    
    def create_or_update_user_from_entry(entry)
      if user = UcbRails::User.find_by_uid(entry.uid)
        update_user_from_ldap_entry(entry)
      else
        create_user_from_ldap_entry(entry)
      end
    end
  end
end