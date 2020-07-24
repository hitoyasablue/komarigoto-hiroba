class WakarusController < ApplicationController
  include SessionsHelper

  def create
    wakaru = Wakaru.new(user_id: current_user.id, post_id: params[:post_id])
    wakaru.save
    @user = User.find_by(id: current_user.id)
    @post = Post.find_by(id: params[:post_id])
    # @post.create_notification_wakaru!(current_user)
  end

  def destroy
    wakaru = Wakaru.find_by(user_id: current_user.id, post_id: params[:post_id])
    wakaru.destroy
    @user = User.find_by(id: current_user.id)
    @post = Post.find_by(id: params[:post_id])
  end
end
