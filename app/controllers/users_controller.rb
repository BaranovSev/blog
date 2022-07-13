class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :following, :followers] #, :edit, :update, :destroy, :following, :followers]
  # before_action :correct_user, only: [:edit, :update]
  # before_action :admin_user, only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    #debugger
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

end
