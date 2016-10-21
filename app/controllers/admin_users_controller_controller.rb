class AdminUsersControllerController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in

  def index
    @AdminUser = AdminUser.sorted
  end

  def new
    @AdminUser = AdminUser.new
  end

  def create
    @AdminUser = AdminUser.new(admin_user_params)
    if @AdminUser.save
      flash[:notice] = "Admin user '#{@AdminUser.first_name}' created successfully."
      redirect_to(:action => 'index')
    #if save fails, redisplay the form so user can fix problems
    else
      render('new')
    end
  end

  def edit
  	@AdminUser = AdminUser.find(params[:id])
  end

  def update
    @AdminUser = AdminUser.find(params[:id])
    if @AdminUser.update_attributes(admin_user_params)
      flash[:notice] = "Admin user '#{@AdminUser.username}' updated successfully."
      redirect_to(:action => 'index')
    else
      render('edit')
    end
  end

  def delete
    if AdminUser.find(params[:id]).username == session[:username]
      flash[:notice] = "Cannot delete current/own admin user."
      redirect_to(:action => 'index')
    else
      @AdminUser = AdminUser.find(params[:id])
    end
  end

  def destroy
    adminuser = AdminUser.find(params[:id]).destroy
    flash[:notice] = "Admin user '#{adminuser.username}' destroyed successfully."
    redirect_to(:action => 'index')
  end

  private
    def admin_user_params
      params.require(:AdminUser).permit(:first_name, :last_name, :email, :username, :password)
    end

end
