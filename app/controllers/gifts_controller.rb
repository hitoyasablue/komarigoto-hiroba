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

  # def stripe_connect
  #   response = Stripe::OAuth.token({
  #     grant_type: 'authorization_code',
  #     code: params[:id],
  #     assert_capabilities: ['transfers'],
  #   })
  # end

  def create
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    amount = 100
    post = Post.find_by(id: params[:post_id])
    # @reciever_local = User.find_by(id: post.user_id)
    card_sender = Card.find_by(user_id: current_user.id)

    begin

      # 送金先ユーザのStripeアカウント作成
      reciever = Stripe::Account.create({
        type: 'custom',
        country: 'JP',
        # name: @reciever_local.name,
        # email: @reciever_local.email,
        business_type: 'individual',
        capabilities: {
          card_payments: {
            requested: true,
          },
          transfers: {
            requested: true,
          },
        },
      })

      # 証明写真の面裏をStripeサーバにアップロード
      front = Stripe::File.create({
        purpose: 'identity_document',
        file: File.new("app/assets/images/inu.png"),
      })

      back = Stripe::File.create({
        purpose: 'identity_document',
        file: File.new("app/assets/images/neko.png"),
      })

      # 送金先ユーザの作成に必要な情報を追加登録
      stripe_account = Stripe::Account.update(
        reciever.id,
        individual: {
          address_kanji: {
            :postal_code => "150-0013",
            :state => "東京",
            :city => "渋谷区",
            :town => "恵比寿",
            :line1 => "1-1-1",
            :line2 => "テストビルディング101号",
          },
          address_kana: {
            :postal_code => "150-0013",
            :state => "とうきょうと",
            :city => "しぶやく",
            :town => "えびす",
            :line1 => "1-1-1",
            :line2 => "てすとびるでぃんぐ101ごう",
          },
          :first_name_kanji => "太郎",
          :last_name_kanji => "田中",
          :first_name_kana => "たろう",
          :last_name_kana => "たなか",
          dob: {
            :day => "1",
            :month => "1",
            :year => "2000",
          },
          verification: {
            document: {
              :front => front.id,
              :back => back.id,
            }
          },
          :gender => "male",
          :phone => "+819012345678",
        },
        tos_acceptance: {
          :date => Time.now.to_i,
          :ip => "192.168.0.1",
        },
        external_account: {
          :object => 'bank_account',
          :country => 'jp',
          :currency => 'jpy',
          :routing_number => '1100000', #銀行コード+支店コード
          :account_number => '0001234',
          :account_holder_name => 'トクテスト(カ',
        }
      )


      # stripe_account.save

      # token = Stripe::Source.create({
      #   type: 'card',
      #   currency: 'jpy',
      #   usage: 'reusable',
      #   owner: {
      #     email: current_user.email,
      #   },
      # }, {
      #   stripe_account: reciever.id,
      # })

      # gift = Stripe::PaymentIntent.create({
      #   payment_method_types: ['card'],
      #   amount: @amount,
      #   currency: "jpy",
      #   payment_method: token.id,
      #   customer: @card_sender.customer_id, #Stripe.jsで自動で付与されるカード情報のトークン
      #   transfer_data: {
      #     destination: reciever.id,
      #   }
      # })

      # 送金処理
      @gift = Stripe::Charge.create({
        amount: amount,
        currency: "jpy",
        customer: card_sender.customer_id,
        transfer_data: {
          destination: reciever.id,
        }
      })

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

    redirect_to posts_path
    # posts_path and return

  end

  def delete
  end

  def show
  end
end
