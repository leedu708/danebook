class CommentsController < ApplicationController

  before_action :require_login, :only => [:create]
  before_action :require_current_user, :only => [:destroy]

  def create

    @new_comment = Comment.new(comment_params)
    if @new_comment.save
      flash[:success] = "Comment successfully created!"
    else
      flash[:danger] = "Comment failed to save - please try again."
    end

    redirect_to users_posts_path(@new_comment.post.author)

  end

  def destroy

    comment = Comment.find(params[:id])
    post_athor = comment.post.author
    if comment.destroy!
      flash[:success] = 'Comment successfully deleted!'
    else
      flash[:danger] = 'Comment failed to be deleted - please try again.'
    end

    redirect_to users_posts_path(post_author)

  end

  private

  def comment_params

    params.require(:comment).permit(:body, :author_id, :post_id)

  end

  def require_current_user

    comment = Comment.find(params[:id])
    unless comment.author == current_user
      flash[:danger] = "Unauthorized Access."
      redirect_to users_posts_path(comment.post.author)
    end

  end
  
end
