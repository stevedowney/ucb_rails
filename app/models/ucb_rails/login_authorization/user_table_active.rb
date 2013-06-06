class UcbRails::LoginAuthorization::UserTableActive
  class << self
    
    def authorized?(uid)
      UcbRails::User.active.find_by_uid(uid).present?
    end
    
  end
end