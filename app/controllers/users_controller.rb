class UsersController < ApplicationController
  before_action :required_login, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      flash[:success] = "Welcome to Elearning System"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    # @users = User.all
    @users = User.paginate(page: params[:page], per_page: 10).order('created_at DESC')
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(users_params)
      redirect_to user_url(@user)
    else 
      render 'edit'
    end
  end

  def following
    @user = User.find(params[:id])
    @title = "Following"
    @users = @user.following.paginate(page: params[:page])
    render "users/follow"
  end

  def followers
    @user = User.find(params[:id])
    @title = "Follower"
    @users = @user.followers.paginate(page: params[:page])
    render "users/follow"
  end

  def required_login
    unless signed_in?
      redirect_to signin_url
    end
  end

  private
    def users_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache, :remove_image)
    end
end
