class ProgressesController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: [:create, :destroy]

  def new
    @progress = Progress.new
  end

  def create
    post = Post.find_by(id: params[:post_id])
    @progress = post.progresses.new(progress_params)
    if @progress.save
      flash[:success] = '進捗を記録しました'
      redirect_to posts_url
    else
      render 'new'
    end
  end

  def show
    @user = Post.find_by(id: params[:post_id]).user
    @post = Post.find_by(id: params[:post_id])
  end

  def edit
  end

  def update
    post = Post.find_by(id: params[:post_id])
    @progress = Progress.find_by(id: params[:post_id])
  end

  def destroy
    Progress.find_by(id: params[:id]).destroy
    flash[:success] = '進捗を削除しました'
    redirect_to posts_url
  end

  private

    def progress_params
      params.require(:progress).permit(:content)
    end
end
