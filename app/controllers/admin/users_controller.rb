class Admin::UsersController < ApplicationController
  before_action :required_login, :admin_user

  def index
    @users = User.paginate(page: params[:page], per_page: 10).order('created_at DESC')
  end

  def update
    @user = User.find(params[:id])
    @user.update(admin: true)

    redirect_to admin_users_url
  end

  def destroy
    @user = User.find(params[:id])
    @user.update(admin: false)

    redirect_to admin_users_url
  end
end
