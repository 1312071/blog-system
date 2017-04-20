class CommentsController < ApplicationController
  def new
  end

  def create
    @comment = Comment.new
    @comment.user_id = current_user.id
    @comment.entry_id = param[:entry][:id]
    @comment.content = params[:content]
    if @comment.save
      flash[:success] = t ".commented"
    else
      flash[:danger] = t ".comment_failed"
    end
    redirect_to root_url
  end
end
