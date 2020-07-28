class OuensController < ApplicationController
  include SessionsHelper

  def create
    ouen = Ouen.new(user_id: current_user.id, post_id: params[:post_id])
    ouen.save
    @user = User.find_by(id: current_user.id)
    @post = Post.find_by(id: params[:post_id])
    @post.create_notification_ouen!(current_user)
  end

  def destroy
    ouen = Ouen.find_by(user_id: current_user.id, post_id: params[:post_id])
    ouen.destroy
    @user = User.find_by(id: current_user.id)
    @post = Post.find_by(id: params[:post_id])
  end
end
