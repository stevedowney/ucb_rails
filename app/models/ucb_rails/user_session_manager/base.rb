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

  def people_ou_entry(uid_in=nil)
    self.uid = uid_in if uid_in.present?
    
    @people_ou_entry ||= begin
      if @people_ou_entry = UcbRails::LdapPerson::Finder.find_by_uid(uid)
        @people_ou_entry
      else
        UcbRails.logger.debug "#{self.class} people_ou_entry not found for uid: #{uid.inspect}"
        nil
      end
    end
  end
  
  private
  
  def active_user
    @active_user ||= UcbRails::User.active.find_by_uid(uid)
  end
  
  def active_admin_user
    @active_user ||= UcbRails::User.active.admin.find_by_uid(uid)
  end

  def ldap_person_user_wrapper(ldap_person_entry)
    UcbRails::UserSessionManager::LdapPersonUserWrapper.new(ldap_person_entry)
  end
  
  class << self
    def current_user=(user)
      Thread.current[:current_user] = user
    end
    
    def current_user
      Thread.current[:current_user]
    end
  end
end