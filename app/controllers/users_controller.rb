class UsersController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only:[:show, :index, :edit, :update, :destroy]
  before_action :correct_user, only:[:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.all.order(created_at: :desc)
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts.order(id: 'DESC').page(params[:page]).per(10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.image = image
    if @user.save
      log_in @user
      flash[:success] = 'ログインしました'
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user.update(user_params)
      flash[:success] = 'プロフィールを更新しました'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = 'ユーザーは削除されました'
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end

    def correct_user
      @user = User.find_by(id: params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def image
      @user = User.new(user_params)
      rand = rand(10)
      if rand == 0
        @user.image = 'hukurou.png'
      end
      if rand == 1
        @user.image = 'inu.png'
      end
      if rand == 2
        @user.image = 'inu2.png'
      end
      if rand == 3
        @user.image = 'kame.png'
      end
      if rand == 4
        @user.image = 'neko.png'
      end
      if rand == 5
        @user.image = 'neko2.png'
      end
      if rand == 6
        @user.image = 'neko3.png'
      end
      if rand == 7
        @user.image = 'pengin.png'
      end
      if rand == 8
        @user.image = 'pengin2.png'
      end
      if rand == 9
        @user.image = 'tori.png'
      end
      if rand == 10
        @user.image = 'tori2.png'
      end
    end
end
