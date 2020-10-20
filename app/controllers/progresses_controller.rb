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
      if @progress.optional_content_3.present?
        flash[:success] = '最後まで書いてすごい！ あなたが今日心おだやかでありますように・・・'
      elsif @progress.optional_content_2.present?
        flash[:success] = '無理のない範囲で、今できることを実行してみてくださいね。おうえんしています'
      else
        flash[:success] = '進捗を投稿しました！'
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
      redirect_to post_progresses_url
    else
      render 'edit'
    end
  end

  def index
    @post = Post.find_by(id: params[:post_id])
    @progress = Progress.find_by(id: params[:id])
  end

  def destroy
    Progress.find_by(id: params[:id]).destroy
    flash[:success] = '進捗を削除しました'
    redirect_to posts_url
  end

  private

    def progress_params
      params.require(:progress).permit(:content, :content_2, :optional_content, :optional_content_2, :optional_content_3, :optional_content_4)
    end
end
