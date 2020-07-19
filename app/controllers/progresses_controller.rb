class ProgressesController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: [:create, :destroy]

  def new
    @progress = Progress.new
  end

  def create
    @post = Post.find(params[:post_id])
    @progress = @post.progresses.new(progress_params)
    if @progress.save
      flash[:success] = '進捗を記録しました'
      redirect_to posts_url
    else
      render 'new'
    end
  end

  def show

  end

  def edit
  end

  def update

  end

  def destroy

  end

  private

    def progress_params
      params.require(:progress).permit(:content)
    end
end
