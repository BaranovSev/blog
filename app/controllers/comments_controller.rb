class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy, :update]
  before_action :is_admin, only: :destroy

  def index
    @micropost = Micropost.find(params[:micropost_id])
    @comments = @micropost.comments.paginate(page: params[:page])
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.micropost_id = params[:micropost_id]
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_back fallback_location: root_path
    else
      flash[:alert] = "Comment not created"
      redirect_back fallback_location: root_path
    end
  end

  def edit
    @comment = Comment.find_by(id: params[:id])
  end

  def update
    @comment = Comment.find_by(id: params[:id])
    if @comment.update(update_comment_params)
      redirect_to root_url
    else
      render 'edit'
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id]) # current_user.comments
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to request.referrer || root_url # previous URL or root URl
  end
 
  private

    def comment_params
      params.permit(:content)
      # params.require(:comment).permit(:content) #doesn't work, why!??????
    end
    
    def update_comment_params # ........
      params.require(:comment).permit(:content)
    end

    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end

    def is_admin
      current_user.admin = true
    end
end
