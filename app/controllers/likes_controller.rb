class LikesController < ApplicationController
  include SessionsHelper

  def create
    like = Like.new(user_id: current_user.id, post_id: params[:post_id])
    like.save
    @user = User.find_by(id: current_user.id)
    @post = Post.find_by(id: params[:post_id])
    @post.create_notification_like!(current_user)
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
    like.destroy
    @user = User.find_by(id: current_user.id)
    @post = Post.find_by(id: params[:post_id])
  end
end
