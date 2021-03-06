class LikesController < ApplicationController
  before_action :find_micropost
  before_action :find_like, only: [:destroy]
  
  def create
    @micropost.likes.create(user_id: current_user.id)
    redirect_back fallback_location: root_path
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
      redirect_back fallback_location: root_path
    end
  end

  private
  
  def find_micropost
    @micropost = Micropost.find(params[:micropost_id])
  end
  
  def find_like
    @like = @micropost.likes.find(params[:id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, micropost_id:
    params[:micropost_id]).exists?
  end
end
