class SessionsController < ApplicationController
  include SessionsHelper

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] = 'ログインしました'
      redirect_back_or user
    else
      flash.now[:danger] = 'メールアドレス、またはパスワードが誤っています'
      render 'new'
    end
  end

  def destroy
    reset_session
    redirect_to root_url
  end
end
