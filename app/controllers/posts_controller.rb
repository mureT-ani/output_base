class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new edit]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :contributor_check, only: %i[edit update destroy]

  def index
    @post = Post.includes(:user).order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    tag_list = params[:post][:name].split(",")
    if @post.valid?
      @post.save
      @post.save_posts(tag_list)
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @good = Good.find_by(post_id: @post.id)
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def contributor_check
    redirect_to root_path if current_user.id != @post.user_id
  end

  def post_params
    params.require(:post).permit(:title, :post_text).merge(user_id: current_user.id)
  end
end
