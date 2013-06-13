module UcbRails::Admin::UsersHelper
  
  def link_to_new_user
    button('New User', :primary, 
      class: 'ldap-person-search',
      data: {
        search_url: ldap_search_ucb_rails_admin_users_path,
        result_link_url: ucb_rails_admin_users_path,
        result_link_http_method: 'post',
      }
    )
  end
  
end