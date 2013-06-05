# note: all options accept lambdas

UserAnnouncements.config do |config|

  using_bootstrap = true
  
  if using_bootstrap
    config.bootstrap = true
    config.bootstrap_datetime_picker = true
    config.styles = [['Yellow', ''], ['Red', 'alert-error'], ['Green', 'alert-success'], ['Blue', 'alert-info']]
  else
    config.bootstrap = false
    config.bootstrap_datetime_picker = false
    config.styles = [['Yellow', 'yellow'], ['Red', 'red'], ['Green', 'green'], ['Blue', 'blue']]
  end

  # Announcement defaults
  config.default_active = true
  config.default_starts_at = lambda { Time.now.in_time_zone }
  config.default_ends_at = lambda { 1.week.from_now.in_time_zone.end_of_day }
  config.default_style = ''
  # config.default_roles = ['admin']

  # Roles
  # Setting config.roles will show roles on the Announcment detail form and cause
  # roles to be considered in showing announcements to users
  # config.roles = []
  # config.roles = ['', 'admin']
  # config.roles = [ ['Public', ''], ['Administrator', 'admin'] ]
  # config.roles = lambda { MyRoleClass.all.map { |role| [role.name, role.id] } }  
  
end