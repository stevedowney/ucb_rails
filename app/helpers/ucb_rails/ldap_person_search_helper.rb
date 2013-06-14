module UcbRails::LdapPersonSearchHelper
  
  def link_to_ldap_person_entry(entry)
    UcbRails::Renderer::LdapPersonSearchResultLink.new(self, entry).html
  end
  
  def ldap_entry_class(entry)
    Array['ldap-result'].tap do |result|
      result << 'ldap-result-exists' if ldap_already_include?(entry.uid)
    end
  end
  
  def ldap_already_include?(uid)
    ldap_person_search_existing_uids.include?(uid.to_s)
  end
  
  def ldap_person_search_existing_uids
    @ldap_person_search_existing_uids ||= (@lps_existing_uids || []).map(&:to_s)
  end
  
end