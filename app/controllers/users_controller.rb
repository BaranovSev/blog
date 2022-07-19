class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :following, :followers] #, :edit, :update, :destroy, :following, :followers]
  before_action :is_admin, only: :destroy
  # before_action :correct_user, only: [:edit, :update]
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    #debugger
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  # def destroy
  #   @user = User.find(params[:id])
  #   @user.destroy

  #   if @user.destroy
  #       redirect_to root_url, notice: "User deleted."
  #   end
  # end
  
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
  
  private

  def is_admin
    current_user.admin = true
  end

end
