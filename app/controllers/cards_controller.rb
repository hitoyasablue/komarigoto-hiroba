class CardsController < ApplicationController
  # stripeAPI用のメソッドなどを使用できるようにする
  require "stripe"

  def new
    # あらかじめ環境変数に入れておいたテスト用公開鍵を、gonのメソッドにセット
    gon.stripe_public_key = ENV['STRIPE_PUBLISHABLE_KEY']
    card = Card.where(user_id: current_user.id)
    # カードのデータが既にDBに存在していた場合は指定したページに遷移
    redirect_to new_post_gift_url(id: params[:id]) if card.exists?
  end

  def create
    # あらかじめ環境変数に入れておいたテスト用秘密鍵をセット
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    # トークンが生成されていなかった場合は何もせずリダイレクト
    if params['stripeToken'].blank?
      redirect_to posts_url
    else
      # 送信元ユーザのStripeアカウントを生成
      sender = Stripe::Customer.create({
        name: current_user.name,
        email: current_user.email,
        source: params['stripeToken'],
      })
      # CardテーブルにログインユーザのこのアプリでのIDと、StripeアカウントでのIDを保存
      @card = Card.new(
        user_id: current_user.id,
        customer_id: sender.id,
        card_id: params['stripeToken'],
      )
      if @card.save
        redirect_to new_post_gift_url(id: params[:id])
      else
        redirect_to posts_url
      end
    end
  end

  def delete
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      # retrieveする
    end
    redirect_to posts_url
  end
end
