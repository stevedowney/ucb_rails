class UcbRails::LdapPersonSearchController < ApplicationController
  NoSearchTermError = Class.new(StandardError)
  
  skip_before_filter :ensure_authenticated_user

  def search
    @lps_entries = UcbRails::LdapPerson::Finder.find_by_first_last(
      params.fetch(:first_name),
      params.fetch(:last_name),
      :sort => :last_first_downcase
    )
    render 'ucb_rails/lps/search'
  end
    
end