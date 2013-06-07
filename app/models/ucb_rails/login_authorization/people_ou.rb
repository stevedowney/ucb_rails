class UcbRails::LoginAuthorization::PeopleOu
  class << self
    
    def authorized?(uid)
      if UCB::LDAP::Person.find_by_uid(uid)
        UcbRails.logger.debug "PeopleOu authorization successful for uid: #{uid.inspect}"
        true
      else
        UcbRails.logger.debug "PeopleOu authorization failed for uid: #{uid.inspect}"
        false
      end
    end
    
  end
end