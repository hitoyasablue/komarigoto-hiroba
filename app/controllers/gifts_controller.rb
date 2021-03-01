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
          :gender => "male",
          # :phone => "555-555-0000",
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

      # stripe_account = Stripe::Account.retrieve(reciever.id)

      # # 事業者の種類（法人 or 個人）
      # stripe_account.business_type = "individual" #個人
      # stripe_account.external_accounts.create({
      #   :external_account => {
      #     'object':'bank_account',
      #     'account_number': '0001234',
      #     'routing_number': '1100000', #銀行コード+支店コード
      #     'account_holder_name':'トクテスト(カ',
      #     'currency':'jpy',
      #     'country':'jp'
      #   }
      # })

      # byebug

      # 事業者の住所（漢字）
      # stripe_account.individual.address_kanji.postal_code = "1234567"
      # stripe_account.individual.address_kanji.state = "東京"
      # stripe_account.individual.address_kanji.city = "渋谷区"
      # stripe_account.individual.address_kanji.town = "恵比寿"
      # stripe_account.individual.address_kanji.line1 = "1-1-1"
      # stripe_account.individual.address_kanji.line2 = "テストビルディング101号"

      # # 事業者の住所（かな）
      # # stripe_account.individual.address_kana.postal_code = "1234567"
      # stripe_account.individual.address_kana.state = "とうきょうと"
      # stripe_account.individual.address_kana.city = "しぶやく"
      # stripe_account.individual.address_kana.town = "えびす"
      # stripe_account.individual.address_kana.line1 = "1-1-1"
      # stripe_account.individual.address_kana.line2 = "てすとびるでぃんぐ101ごう"

      # # 事業責任者の名前（漢字）
      # stripe_account.individual.first_name_kanji = "太郎"
      # stripe_account.individual.last_name_kanji = "田中"

      # # 事業責任者の名前（かな）
      # stripe_account.individual.first_name_kana = "たろう"
      # stripe_account.individual.last_name_kana = "たなか"

      # # 事業者責任者の誕生日
      # stripe_account.individual.dob.day = "1"
      # stripe_account.individual.dob.month = "1"
      # stripe_account.individual.dob.year = "2000"

      # # # 事業責任者の性別
      # stripe_account.individual.gender = "male"

      # # # 事業責任者の電話番号
      # stripe_account.individual.phone = "090-0000-0000"

      # # 受理された日付とグローバルIPアドレス
      # stripe_account.tos_acceptance.date = Time.now.to_i
      # stripe_account.tos_acceptance.ip = "192.168.0.1" #グローバルIPアドレスを入力

      # Stripeに画像ファイルをアップロードするための処理
      # 免許証やパスポートなどをアップロードする
      # verification_document = Stripe::File.new(
      #   {
      #     purpose: 'identity_document',
      #     file: File.new("/Users/yusaku/works/komarigoto_hiroba/app/assets/images/inu.png")
      #   },
      #   {
      #     stripe_account: stripe_account_id
      #   }
      # )

      # # アップロードされたドキュメントのID番号
      # stripe_account.individual.verification.document = verification_document.id

      stripe_account.save

      gift = Stripe::PaymentIntent.create({
        payment_method_types: ['card'],
        amount: @amount,
        currency: "jpy",
        customer: @card_sender.customer_id, #Stripe.jsで自動で付与されるカード情報のトークン
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

    posts_path and return

  end

  def delete
  end

  def show
  end
end
