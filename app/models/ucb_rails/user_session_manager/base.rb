class UcbRails::UserSessionManager::Base
  attr_accessor :uid
  
  def login(uid)
    false
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