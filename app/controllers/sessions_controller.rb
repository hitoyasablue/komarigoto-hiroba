class SessionsController < ApplicationController
  include SessionsHelper

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = 'ログインしました'
      redirect_back_or posts_url
    else
      flash.now[:danger] = 'メールアドレス、またはパスワードが正しくありません'
      render 'new'
    end
  end

  def destroy
    reset_session
    redirect_to root_url
  end
end
