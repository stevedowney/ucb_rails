class UcbRails::Admin::UsersController < UcbRails::Admin::BaseController
  before_filter :find_user, :only => [:edit, :update, :destroy]
  respond_to :html, :js
  
  def index
    respond_to do |format|
      format.html { @users = UcbRails::User.all }
      format.json { render json: UcbRails::UsersDatatable.new(view_context) }
    end
  end
  
  def edit
  end
  
  def create
    uid = params.fetch(:uid)
    if user = UcbRails::User.find_by_uid(uid)
      flash[:warning] = "User already exists"
    else
      user = UcbRails::UserLdapService.create_user_from_uid(uid)
      flash[:notice] = 'Record created'#msg_created(user)
    end
    # render :js => %(window.location.href = '#{ucb_rails_admin_user_path}')
    render :js => %(window.location.href = '#{edit_ucb_rails_admin_user_path(user)}')
  end
  
  def update
    if @user.update_attributes(params.fetch(:ucb_rails_user), :without_protection => true)
      redirect_to(ucb_rails_admin_users_path, notice: 'Record updated')
    else
      render("edit")
    end
  end
  
  def destroy
    if @user.destroy
      flash[:notice] = 'Record deleted' #msg_destroyed(@user)
    else
      flash[:error] = @user.errors[:base].first
    end

    redirect_to(ucb_rails_admin_users_path)
  end

  def ldap_search
    @lps_entries = UcbRails::LdapPerson::Finder.find_by_first_last(
      params.fetch(:first_name),
      params.fetch(:last_name), 
      :sort => :last_first_downcase
    )
    @lps_existing_uids = UcbRails::User.where(uid: @lps_entries.map(&:uid)).pluck(:uid)

    render 'ucb_rails/lps/search'
  end

  def typeahead_search
    uta = UcbRails::UserTypeahead.new
    render json: uta.results(params.fetch(:query))
  end
  
  private

  def find_user
    @user ||= UcbRails::User.find(params.fetch(:id))
  end
  
end