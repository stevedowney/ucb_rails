class UcbRails::UserLdapService
  
  class << self
    
    def create_user(uid)
      ldap_entry = UcbRails::LdapPerson::Finder.find_by_uid!(uid)
      
      UcbRails::User.create! do |u|
        u.uid = ldap_entry.uid
        u.first_name = ldap_entry.first_name
        u.last_name = ldap_entry.last_name
        u.email = ldap_entry.email
        u.phone = ldap_entry.phone
        
      end
      
    end
    
    def update_user(uid)
      ldap_entry = UcbRails::LdapPerson::Finder.find_by_uid!(uid)
      user = UcbRails::User.find_by_uid!(uid)
      user.first_name = ldap_entry.first_name
      user.last_name = ldap_entry.last_name
      user.email = ldap_entry.email
      user.phone = ldap_entry.phone
      user.save(validate: false)
      user
    end
    
    def create_or_update_user(uid)
      if user = UcbRails::User.find_by_uid(uid)
        update_user(uid)
      else
        create_user(uid)
      end
    end
  end
end