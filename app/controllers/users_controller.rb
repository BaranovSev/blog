class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show] #, :edit, :update, :destroy, :following, :followers]
  # before_action :correct_user, only: [:edit, :update]
  # before_action :admin_user, only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    #debugger
    #@microposts = @user.microposts.paginate(page: params[:page])
    @feed_items = @user.microposts.paginate(page: params[:page])
  end

end
