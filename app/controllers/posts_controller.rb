class PostsController < ApplicationController
before_action :set_post, only: %i[show edit update]

  def index
    @post = Post.includes(:user).order("created_at DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.valid?
      @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end


  private

  def post_params
    params.require(:post).permit(:title, :post_text).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
