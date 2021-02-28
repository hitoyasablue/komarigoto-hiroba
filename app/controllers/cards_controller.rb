class CardsController < ApplicationController
  require "stripe"

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to new_gift_url if card.exists?
  end

  def create
    Stripe.api_key = 'sk_test_51IOzkSI7CbPhhw7oV80cldziv9UQoH0DpGbCHYEVEtalacCbcZg2Ms8NCfpW8a6deZ1iLZI0oemYn2VyyQf9V2zY00K2Z8HeRw'
    if params['stripeToken'].blank?
      redirect_to ports_url
    else
      sender = Stripe::Customer.create({
        name: current_user.name,
        email: current_user.email,
        source: params['stripeToken'],
      })
      @card = Card.new(
        user_id: current_user.id,
        customer_id: sender.id,
        card_id: params['stripeToken'],
      )
      if @card.save
        redirect_to new_gift_url
      else
        redirect_to posts_url
      end
    end
  end

  def delete
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = 'sk_test_81f3183a95db326cb5db9158'
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to new_post_card_url(id: params[:id])
  end

  def show
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to new_post_card_url(id: params[:id])
    else
      Payjp.api_key = 'sk_test_81f3183a95db326cb5db9158'
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end
end
