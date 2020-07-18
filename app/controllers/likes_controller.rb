class LikesController < ApplicationController
  include SessionsHelper

  def create
    like = Like.new(user_id: current_user.id, post_id: params[:post_id])
    like.save
    @user = User.find(current_user.id)
    @post = Post.find(params[:post_id])
  end

  def destroy
    like = Like.find_by(post_id: params[:post_id], user_id: current_user)
    like.destroy
    @user = User.find(current_user.id)
    @post = Post.find(params[:post_id])
  end


  # def create
  #   @post = Post.find(params[:post_id])
  #   unless @post.liked?(current_user)
  #     @post.like(current_user)
  #     # like = Like.new(user_id: current_user.id, post_id: params[:post_id])
  #     # like.save
  #     respond_to do |format|
  #       format.html { redirect_to request.referer || root_url }
  #       format.js
  #     end
  #   end
  #   # @post.like(current_user)
  # end

  # def destroy
  #   @post = Like.find(params[:id]).post
  #   if @post.liked?(current_user)
  #     @post.unlike(current_user)
  #     # like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
  #     # like.destroy
  #     respond_to do |format|
  #       format.html { redirect_to request.referrer || root_url }
  #       format.js
  #     end
  #   end

  #   # @post.unlike(current_user)
  # end
end
