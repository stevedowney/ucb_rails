class UcbRails::LdapPersonSearchController < ApplicationController
  NoSearchTermError = Class.new(StandardError)
  
  skip_before_filter :ensure_authenticated_user

  rescue_from UcbRails::LdapPerson::Finder::BlankSearchTermsError do
    render :js => %(alert("Enter search terms"))
  end

  def search
    get_entries
  end
    
  def search_add_user
    get_entries
    @ldap_already = UcbRails::User.where(uid: @ldap_entries.map(&:uid)).pluck(:uid)
    render 'search'
  end
    
  private
  
  def get_entries
    first_name = params.fetch(:first_name)
    last_name = params.fetch(:last_name)
    @ldap_entries = UcbRails::LdapPerson::Finder.find_by_first_last(first_name, last_name, :sort => :last_first_downcase)
  end

end