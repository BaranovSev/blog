class MicropostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy, :update]
  before_action :is_admin, only: :destroy
  
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

  def edit
    @micropost = Micropost.find_by(id: params[:id])
    render 'edit'
  end

  def update
    @micropost = Micropost.find_by(id: params[:id])
    if @micropost.update(micropost_params)
    redirect_to root_url
    else 
      render 'edit'
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

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

    def is_admin
      current_user.admin = true
    end
end
