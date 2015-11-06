class LikesController < ApplicationController

  before_action :require_login

  def create

    @liker = current_user
    @liked = Post.find(params[:liked_id])
    if @liker.liked_posts << @liked
      flash[:success] = 'You have liked a post!'
    else
      flash[:danger] = 'Failed to like post.'
    end

    redirect_to :back

  end

  def destroy

    if Like.find(params[:id]).destroy
      flash[:success] = 'You have unliked a post!'
    else
      flash[:danger] = 'Failed to unlike post.'
    end

    redirect_to :back

  end
  
end
