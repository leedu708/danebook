class CommentsController < ApplicationController

  before_action :require_login

  def create

    @new_comment = Comment.new(comment_params)
    if @new_comment.save
      flash[:success] = "Comment successfully created!"
    else
      flash[:danger] = "Comment failed to save - please try again."
    end

    redirect_to :back

  end

  private

  def comment_params

    params.require(:comment).permit(:body, :author_id, :post_id)

  end
  
end
