module UcbRails::LdapPersonSearchHelper
  
  def ldap_person_search_link(*args)
    options = canonicalize_options(args.extract_options!)
    options = ensure_class(options, 'ldap-person-search')
    
    text = args.shift || 'Search CalNet'
    
    options[:data] = {
      result_link_text: options.delete(:result_link_text).presence || 'Add',
      result_link_class: options.delete(:result_link_class),
    }
    link_to(text, js_void, options)
  end

  def link_to_ldap_person_entry(entry)
    return UcbRails::Renderer::LdapPersonSearchResultLink.new(self, entry).html
    
    href = params["item-url"] 
    text = params["item-label"].presence || "Add"
    
    unless item_url.present? || item_js.present?
      return link_to(text, js_void, class: 'no-url-or-js-function-given')
    end
    
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
  
  
  # def link_to_new_user
  #   link_to('New User', js_void, 
  #     :class => 'ldap-person-search btn btn-primary',
  #     :style => "font-weight: normal",
  #     :id => 'new_user_link',
  #     :style => "font-size: 15px; font-weight: normal",
  #     :data => {
  #       :http_method => 'post',
  #       :js => true,
  #       :item_label => 'Add',
  #       :item_url => ucb_rails_admin_users_path
  #     }
  #   )
  # end
  
  
  # def link_to_ldap_person_entry(uid)
  #   if ldap_already_include?(uid)
  #     return 'exists'
  #   end
  #   
  #   item_label = params["item-label"].presence || "Add"
  #   klass = "btn btn-mini btn-primary ldap-entry"
  #   id = "uid-#{uid}"
  #   connector = params["item-url"].include?("?") ? '&' : '?'
  #   url = "#{params["item-url"]}#{connector}uid=#{uid}"
  #   remote = params[:js].present?
  #   method = params['http-method'].presence || :get
  #   link_to(item_label, url, :remote => remote, :method => method, :class => klass, :id => id ) 
  # end
  
end