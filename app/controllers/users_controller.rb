class UsersController < ApplicationController
before_action :set_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    @user.save
  end
  
  def update
    if @user.update(user_params)
      redirect_to @user , notice: 'プロフィールを編集しました'
    else
      render 'edit_user_url'
    end
  end
  
  # /users/:id/followings
  def followings
    @user = User.find(params[:id])
    @users = @user.following_users
  end
  
  # /users/:id/followers
  def followers
    @user = User.find(params[:id])
    @users = @user.follower_users
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
