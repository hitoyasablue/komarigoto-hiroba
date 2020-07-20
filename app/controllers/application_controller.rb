class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception
  add_flash_types :success, :info, :warning, :danger

  private

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = 'ログインをしてください'
        redirect_to login_url
      end
    end
end
