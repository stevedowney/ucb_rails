class UcbRails::UsersDatatable < UcbRails::BaseDatatable

  private

  def default_scope
    UcbRails::User
  end
  
  def column_names
    @column_names ||= %w[admin inactive first_name last_name email phone last_request_at uid]
  end
  
  def search(search_term)
    ["first_name like :search or last_name like :search", search: "#{search_term}%"]
  end
  
  def record_to_data(user)
    [
      bln(user.admin),
      bln(user.inactive),
      h(user.first_name),
      h(user.last_name),
      h(user.email),
      h(user.phone),
      h(user.last_request_at),
      h(user.uid),
      link_to("Edit", edit_ucb_rails_admin_user_path(user), :id => dom_id(user)),
      link_to('Delete', ucb_rails_admin_user_path(user), :method => :delete, :confirm => 'Are you sure?'),
    ]
  end

end