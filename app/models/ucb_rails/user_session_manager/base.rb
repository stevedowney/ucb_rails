class UcbRails::UserSessionManager::Base
  attr_accessor :uid
  
  def login(uid)
    raise NotImplementedError
  end
  
  def current_user(uid)
    raise NotImplementedError
  end
  
  def log_request(user)
  end
  
  def logout(user)
  end

  private
  
  def active_user
    @active_user ||= UcbRails::User.active.find_by_uid(uid)
  end
  
  def active_admin_user
    @active_user ||= UcbRails::User.active.admin.find_by_uid(uid)
  end

  def people_ou_entry
    @people_ou_entry ||= UcbRails::LdapPerson::Finder.find_by_uid(uid)
  end
  
end