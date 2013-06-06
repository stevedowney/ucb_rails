class UcbRails::UserSessionManager
  class << self
    
    def login(uid)
      if can_login?(uid)
        UcbRails::UserLdapService.create_or_update_user(uid).tap do |user|
          user.touch(:last_login_at)
        end
      end
    end
    
    def log_request(user)
      user and user.touch(:last_request_at)
    end
    
    def logout(user)
      user and user.touch(:last_logout_at)
    end
    
    def current_user=(user)
      Thread.current[:current_user] = user
    end
    
    def current_user
      Thread.current[:current_user]
    end
    
    def can_login?(uid)
      login_authorization_class.authorized?(uid)
    end
    
    private
    
    def login_authorization_class
      klass = UcbRails[:login_authorization_class] || UcbRails::LoginAuthorization::UserTableActive
      klass.to_s.classify.constantize
    rescue NameError
      raise "Could not find UcbRails login_authorization_class: #{klass}"
    end
    
    #   UcbRails::User.active.find_by_uid(uid)
    #    # ||
    #    #  Faculty.find_by_net_id(uid) ||
    #    #  UserRole.find_by_net_id(uid)
    # end
    
  end
end