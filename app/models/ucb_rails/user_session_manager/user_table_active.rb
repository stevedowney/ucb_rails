class UcbRails::UserSessionManager::UserTableActive

  def login(uid)
    active_user = UcbRails::User.active.find_by_uid(uid)
    people_ou_entry = UcbRails::LdapPerson::Finder.find_by_uid(uid)
    
    if active_user && people_ou_entry
      UcbRails::UserLdapService.update_user_from_ldap_entry(active_user, people_ou_entry)
      active_user.touch(:last_login_at)
      active_user
    else
      false
    end
  end
  
  def current_user(uid)
    if uid.present?
      UcbRails::User.find_by_uid(uid)
    end
  end
  
  def log_request(user)
    if user.present?
      user.touch(:last_request_at)
    end
  end
  
  def logout(user)
    if user.present?
      user.touch(:last_logout_at)
    end
  end

end