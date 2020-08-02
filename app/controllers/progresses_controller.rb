class ProgressesController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: [:create, :destroy]

  def new
    @post = Post.find_by(id: params[:post_id])
    @progress = Progress.new
  end

  def create
    @post = Post.find_by(id: params[:post_id])
    @progress = @post.progresses.new(progress_params)
    if @progress.save
      if @progress.optional_content.present?
        flash[:success] = '最後まで書いてすごい！ あなたが今日心おだやかでありますように・・・'
      else
        flash[:success] = '進捗を記録しました！'
      end
      redirect_to posts_url
    else
      render 'new'
    end
  end

  def show
    @post = Post.find_by(id: params[:post_id])
    @user = @post.user
    @progress = Progress.find_by(id: params[:id])
  end

  def edit
    @post = Post.find_by(id: params[:post_id])
    @progress = Progress.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:post_id])
    @progress = Progress.find_by(id: params[:id])
    if @progress.update(progress_params)
      flash[:success] = '進捗を更新しました'
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    Progress.find_by(id: params[:id]).destroy
    flash[:success] = '進捗を削除しました'
    redirect_to posts_url
  end

  private

    def progress_params
      params.require(:progress).permit(:content, :optional_content, :optional_content_2)
    end
end
