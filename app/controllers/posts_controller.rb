class PostsController < ApplicationController

  before_action :require_current_user, :except => [:index]

  def index

    @user = User.find(params[:user_id])
    @posts = @user.posts
    @new_post = Post.new(:author_id => current_user.id) if current_user

  end

  def create

    @new_post = Post.new(post_params)
    if @new_post.save
      flash[:success] = "New post successfully created!"
      redirect_to [current_user, :posts]
    else
      flash.now[:danger] = "New post failed to save - please try again."
      @user = User.find(params[:user_id])
      @posts = @user.posts
      render :index
    end

  end

  def destroy

    if Post.find(params[:id]).destroy!
      flash[:success] = "Post successfully deleted!"
    else
      flash[:danger] = "Post failed to be deleted - please try again."
    end

    redirect_to user_posts_path(current_user)

  end

  private

  def post_params

    params.require(:post).permit(:author_id, :body)

  end

  def require_current_user

    unless params[:user_id] == current_user.id.to_s
      flash[:danger] = "Unauthorized Access!"
      redirect_to user_posts_path(params[:user_id])
    end

  end
  
end
