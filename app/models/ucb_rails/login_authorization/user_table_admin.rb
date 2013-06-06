class UcbRails::LoginAuthorization::UserTableAdmin
  class << self
    
    def authorized?(uid)
      UcbRails::User.active.admin.find_by_uid(uid).present?
    end
    
  end
end