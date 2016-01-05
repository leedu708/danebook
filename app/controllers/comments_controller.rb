class CommentsController < ApplicationController

  before_action :require_login, :only => [:create]
  before_action :require_current_user, :only => [:destroy]

  def create

    @new_comment = current_user.comments.build(comment_params)

    if @new_comment.save
      flash[:success] = "Comment successfully created!"

      respond_to do |format|
        format.html { redirect_back_or_to(user_posts_path(@new_comment.commentable.poster)) }
        format.js { render :create_success, :status => 200 }
      end

    else
      flash[:danger] = "Comment failed to save - please try again."

      respond_to do |format|
        format.html { redirect_back_or_to(user_posts_path(@new_comment.commentable.poster)) }
        format.js { render :nothing => true, :status => 400 }
      end
    end

  end

  def destroy

    comment = Comment.find(params[:id])
    if comment.destroy!
      flash[:success] = 'Comment successfully deleted!'
    else
      flash[:danger] = 'Comment failed to be deleted - please try again.'
    end

    redirect_to :back

  end

  private

  def comment_params

    params.require(:comment).permit(:body, :commentable_id, :commentable_type)

  end

  def require_current_user

    comment = Comment.find(params[:id])
    unless comment.poster == current_user
      flash[:danger] = "Unposterized Access."
      redirect_to user_posts_path(comment.commentable.poster)
    end

  end
  
end
