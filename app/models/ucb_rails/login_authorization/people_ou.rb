class UcbRails::LoginAuthorization::PeopleOu
  class << self
    
    def authorized?(uid)
      UCB::LDAP::Person.find_by_uid(uid).present?
    end
    
  end
end