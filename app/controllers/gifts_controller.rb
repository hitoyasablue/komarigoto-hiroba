class GiftsController < ApplicationController
  require 'payjp'

  def new
  end

  def index
  end

  def pay
    Payjp.api_key = 'sk_test_81f3183a95db326cb5db9158'
    Payjp::Charge.create(
      :amount => params[:amount],
      :card => params['payjp-token'],
      :currency => 'jpy'
    )
    flash[:info] = '送金が完了しました'
    redirect_to posts_url
  end

  def delete
  end

  def show
  end
end
