class GiftsController < ApplicationController
  require 'stripe'

  def new
  end

  def index
  end

  # def stripe_connect
  #   auth_data = request.env["omniauth.auth"]
  #   @user = current_user
  #   if @user.persisted?
  #     @user.access_code = auth_data.credentials.token
  #     @user.publishable_key = auth_data.info.stripe_publishable_key
  #     @user.save

  #     sign_in_and_redirect @user, event: :authentication
  #     flash[:notice] = 'Stripe Account Created And Connected' if is_navigational_format?
  #    else
  #      session["devise.stripe_connect_data"] = request.env["omniauth.auth"]
  #      redirect_to root_path
  #    end
  # end

  def stripe_connect
    response = Stripe::OAuth.token({
      grant_type: 'authorization_code',
      code: params[:id],
      assert_capabilities: ['transfers'],
    })
  end

  def create
    Stripe.api_key = 'sk_test_51IOzkSI7CbPhhw7oV80cldziv9UQoH0DpGbCHYEVEtalacCbcZg2Ms8NCfpW8a6deZ1iLZI0oemYn2VyyQf9V2zY00K2Z8HeRw'
    @amount = 100
    @post = Post.find_by(id: params[:post_id])
    @reciever_local = User.find_by(id: @post.user_id)
    @card_sender = Card.find_by(user_id: current_user.id)

    # byebug

    begin

      reciever = Stripe::Account.create({
        type: 'express',
        country: "JP",
        # name: @reciever_local.name,
        # email: @reciever_local.email,
        capabilities: {
          card_payments: {requested: true},
          transfers: {requested: true},
        },
      })

      # byebug

      account_links = Stripe::AccountLink.create({
        account: reciever.id,
        refresh_url: 'http://localhost:3000',
        return_url: 'http://localhost:3000/posts',
        type: 'account_onboarding',
      })

      # cardholder = Stripe::Issuing::Cardholder.create({
      #   name: 'Jenny Rosen',
      #   status: 'active',
      #   type: 'individual',
      #   billing: {
      #     address: {
      #       line1: '1234 Main Street',
      #       city: 'San Francisco',
      #       state: 'CA',
      #       postal_code: '94111',
      #       country: 'US',
      #     },
      #   },
      # })

      # card = Stripe::Issuing::Card.create({
      #   cardholder: cardholder.id,
      #   type: 'virtual',
      #   currency: 'jpy',
      # })

      # @card_sender = Stripe::Card.create({
      #   source: @card_sender.card_id,
      # })

      @gift = Stripe::PaymentIntent.create({
        amount: 100,
        currency: "jpy",
        payment_method_types: ['card'],
        # payment_method_data: {
        #   type: 'card',
        #   metadata: {
        #     'token': @card_sender.card_id
        #   },
        # },
        customer: @card_sender.customer_id,
        # payment_method: ,
        transfer_data: {
          destination: reciever.id,
        },
      })

      # @gift = Stripe::Charge.create({
      #   amount: 100,
      #   currency: "jpy",
      #   customer: @card_sender.customer_id,
      #   transfer_data: {
      #     destination: reciever.id,
      #   },
      # })

    # stripe関連でエラーが起こった場合
    rescue Stripe::CardError => e
      flash[:error] = "#決済(stripe)でエラーが発生しました。{e.message}"
      render :new

      # Invalid parameters were supplied to Stripe's API
    rescue Stripe::InvalidRequestError => e
      flash.now[:error] = "決済(stripe)でエラーが発生しました（InvalidRequestError）#{e.message}"
      render :new

    # Authentication with Stripe's API failed(maybe you changed API keys recently)
    rescue Stripe::AuthenticationError => e
      flash.now[:error] = "決済(stripe)でエラーが発生しました（AuthenticationError）#{e.message}"
      render :new

    # Network communication with Stripe failed
    rescue Stripe::APIConnectionError => e
      flash.now[:error] = "決済(stripe)でエラーが発生しました（APIConnectionError）#{e.message}"
      render :new

    # Display a very generic error to the user, and maybe send yourself an email
    rescue Stripe::StripeError => e
      flash.now[:error] = "決済(stripe)でエラーが発生しました（StripeError）#{e.message}"
      render :new

    # stripe関連以外でエラーが起こった場合
    rescue => e
      flash.now[:error] = "エラーが発生しました#{e.message}"
      render :new
    end

    posts_path and return

  end

  def delete
  end

  def show
  end
end
