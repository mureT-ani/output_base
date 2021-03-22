class GoodsController < ApplicationController
  before_action :authenticate_user!
  def create
    @good = current_user.goods.create(post_id: params[:post_id])
    redirect_to post_path(params[:post_id])
  end

  def destroy
    @good = Good.find_by(post_id: params[:post_id], user_id: current_user.id)
    @good.destroy
    redirect_to post_path(params[:post_id])
  end
end
