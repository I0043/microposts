class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc) # この行を追加
      render 'static_pages/home'
    end
  end
    
  def destroy
    @micropost = current_user.microposts.find_by(id: params[:id])
    return redirect_to root_url if @micropost.nil?
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end
  
  def like
    @micropost = Micropost.find(params[:id])
    # Like.create(micropost_id: @micropost_id, user_id: current_user.id)
    # current_user.likes.create(micropost_id: @micropost.id)
    current_user.like(@micropost)
    redirect_to root_url
  end
  
  def unlike
  end
  
  private
  def micropost_params
    params.require(:micropost).permit(:content)
  end
end