class TeineisController < ApplicationController
  include SessionsHelper

  def create
    teinei = Teinei.new(user_id: current_user.id, post_id: params[:post_id])
    teinei.save
    @user = User.find_by(id: current_user.id)
    @post = Post.find_by(id: params[:post_id])
    # @post.create_notification_teinei!(current_user)
  end

  def destroy
    teinei = Teinei.find_by(user_id: current_user.id, post_id: params[:post_id])
    teinei.destroy
    @user = User.find_by(id: current_user.id)
    @post = Post.find_by(id: params[:post_id])
  end
end
