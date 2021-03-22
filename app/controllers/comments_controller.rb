class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[destroy comment_user_check]
  before_action :comment_user_check, only: %i[destroy]

  def create
    @comment = Comment.new(comment_params)
    if @comment.valid?
      @comment.save
      redirect_to post_path(@comment.post.id)
    else
      render_to_show
    end
  end

  def destroy
    if @comment.destroy
      redirect_to post_path(params[:post_id])
    else
      render_to_show
    end
  end

  private

  def set_comment
    @comment = Comment.find_by(id: params[:id], post_id: params[:post_id])
  end

  def comment_user_check
    redirect_to root_path if current_user.id != @comment.user_id
  end

  def comment_params
    params.require(:comment).permit(:comment_text).merge(user_id: current_user.id, post_id: params[:post_id])
  end

  def render_to_show
    @post = Post.find(params[:post_id])
    @good = Good.find_by(post_id: @post.id, user_id: current_user.id)
    @comments = @post.comments.includes(:user)
    render 'posts/show'
  end
end
