module UcbRails::Admin::UsersHelper
  
  def link_to_new_user
    link_to('New User', js_void, 
      :class => 'ldap-person-search btn btn-primary',
      :style => "font-weight: normal",
      :id => 'new_user_link',
      :style => "font-size: 15px; font-weight: normal",
      :data => {
        :http_method => 'post',
        :js => true,
        :item_label => 'Add',
        :item_url => ucb_rails_admin_users_path
      }
    )
  end
  
  def ldap_entry_class(uid)
    ldap_already_include?(uid) ? 'ldap-exists' : 'ldap-not-exist'
  end
  
  def ldap_already_include?(uid)
    ldap_already.include?(uid.to_s)
  end
  
  def ldap_already
    @_ldap_already ||= (@ldap_already || []).map(&:to_s)
  end
  
end