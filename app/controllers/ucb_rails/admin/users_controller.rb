class UcbRails::Admin::UsersController < UcbRails::Admin::BaseController
  before_filter :find_user, :only => [:edit, :update, :destroy]
  
  def index
    respond_to do |format|
      format.html { @users = UcbRails::User.all }
      # format.json { render json: UsersDatatable.new(view_context) }
    end
  end
  
  def edit
  end
  
  def create
    uid = params.fetch(:uid)
    if user = UcbRails::User.find_by_uid(uid)
      flash[:warning] = "User already exists"
    else
      user = UcbRails::UserLdapService.create_user(uid)
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

  private

  def find_user
    @user ||= UcbRails::User.find(params.fetch(:id))
  end
  
end