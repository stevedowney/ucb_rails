module UcbRails::ApplicationHelper
  
  def app_name
    "Untitled App"
  end
  
  # TODO: resolve w/handing of brand() in bootstrap-view-helpers
  def app_name_with_env
    RailsEnvironment.production? ? app_name : "#{app_name} - #{Rails.env.titleize}"
  end
  
end