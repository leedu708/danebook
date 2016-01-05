class PostsController < ApplicationController

  before_action :require_current_user, :except => [:index]

  def index

    set_post_vars(params[:user_id])
    @new_post = current_user.posts.build if signed_in_user?

  end

  def create

    @new_post = current_user.posts.build(post_params)

    if @new_post.save
      flash[:success] = "New post successfully created!"
      
      respond_to do |format|
        format.html { redirect_to [current_user, :posts] }
        format.js { render :create_success, :status => 200 }
      end

    else
      flash.now[:danger] = "New post failed to save - please try again."

      respond_to do |format|
        format.html do
          set_post_vars(params[:user_id])
          render :index
        end
        format.js { render :nothing => true, :status => 400 }
      end
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

    params.require(:post).permit(:body)

  end

  def require_current_user

    unless params[:user_id] == current_user.id.to_s
      flash[:danger] = "Unauthorized Access!"
      redirect_to user_posts_path(params[:user_id])
    end

  end

  def set_post_vars(user_id)

    @user = User.find(user_id)
    @posts = @user.posts.order(:created_at => :desc)
    @friends = @user.friended_users.sample(6)
    @photos = @user.photos.sample(9)

  end
  
end
