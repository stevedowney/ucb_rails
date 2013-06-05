module UcbRails::LdapPersonSearchHelper
  
  def link_to_ldap_person_entry(uid)
    if ldap_already_include?(uid)
      return 'exists'
    end
    
    item_label = params["item-label"].presence || "Add"
    klass = "btn btn-mini btn-primary ldap-entry"
    id = "uid-#{uid}"
    connector = params["item-url"].include?("?") ? '&' : '?'
    url = "#{params["item-url"]}#{connector}uid=#{uid}"
    remote = params[:js].present?
    method = params['http-method'].presence || :get
    link_to(item_label, url, :remote => remote, :method => method, :class => klass, :id => id ) 
  end
  
end