class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.valid?
      @comment.save
      redirect_to post_path(@comment.post.id)
    else
      @post = Post.find(params[:post_id])
      @comments = @post.comments.includes(:user)
      render 'posts/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:comment_text).merge(user_id: current_user.id, post_id: params[:post_id])
  end
end
