class UcbRails::LoginAuthorization::UserTableActive

  def login(uid)
    if user = UcbRails::User.active.find_by_uid(uid)
      user.touch(:last_login_at)
      user
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