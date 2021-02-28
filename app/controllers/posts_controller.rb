class PostsController < ApplicationController
  include SessionsHelper
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:show, :index, :edit, :create, :destroy]

  def index
    @posts = Post.all.order(id: 'DESC').page(params[:page]).per(10)
    @like = Like.new(user_id: current_user.id)
    @q = Post.ransack(params[:q])
  end

  def search
    @q = Post.ransack(params[:q], search_posts)
    @posts = @q.result.all.order(id: 'DESC').page(params[:page]).per(10)
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @like = Like.new(user_id: current_user.id, post_id: @post.id)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      if @post.optional_content_4.present?
        # flash[:post] = '最後まで書いてすごい！ あなたが今日心おだやかでありますように・・・'
        flash[:post] = '4'
      elsif @post.optional_content_3.present?
        # flash[:post] = '無理のない範囲で、今できることを実行してみてくださいね。おうえんしています'
        flash[:post] = '3'
      elsif @post.optional_content.present? || @post.optional_content_2.present?
        # flash[:post] = '困りごとを投稿しました。追加項目も書いてすごい！'
        flash[:post] = '2'
      else
        # flash[:post] = '困りごとを投稿しました！'
        flash[:post] = '1'
      end
      redirect_to posts_url
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      flash[:info] = '投稿を更新しました'
      redirect_to posts_url
    else
      render 'edit'
    end
  end

  def destroy
    Post.find_by(id: params[:id]).destroy
    flash[:info] = '投稿を削除しました'
    redirect_to posts_url
  end

  private

    def search_posts
      params.require(:q).permit(:content_or_optional_content_or_optional_content_2_or_optional_content_3_or_optional_content_4_or_optional_content_5_or_optional_content_6_cont)
    end

    def post_params
      params.require(:post).permit(:content, :optional_content, :optional_content_2, :optional_content_3, :optional_content_4, :optional_content_5, :optional_content_6)
    end

    def set_post
      @post = Post.find_by(id: params[:id])
    end
end
