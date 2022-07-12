class MicropostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  #here must be before action for admin 
  # before_action :correct_user, only: :destroy
  
  def create
    @micropost = current_user.microposts.build(micropost_params)
    # @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    # in prev string we find the concrete post, wich we want to delete
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url # previous URL or root URl
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    # def correct_user
    #   @micropost = current_user.microposts.find_by(id: params[:id])
    #   redirect_to root_url if @micropost.nil?
    # end
end
