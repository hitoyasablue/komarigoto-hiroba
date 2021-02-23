class CardsController < ApplicationController
  require "payjp"

  def new
    card = Card.where(user_id: current_user.id)
    redirect_to new_gift_url if card.exists?
  end

  def pay
    Payjp.api_key = 'sk_test_81f3183a95db326cb5db9158'
    if params['payjp_token'].blank?
      redirect_to new_card_url
    else
      customer = Payjp::Customer.create(
      card: params['payjp_token'],
      metadata: {user_id: current_user.id}
      )
      @card = Card.new(
        user_id: current_user.id,
        customer_id: customer.id,
        card_id: customer.default_card
      )
      if @card.save
        redirect_to new_gift_url
      else
        redirect_to pay_cards_url
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
      redirect_to new_card_url
  end

  def show
    card = Card.where(user_id: current_user.id).first
    if card.blank?
      redirect_to new_card_url
    else
      Payjp.api_key = 'sk_test_81f3183a95db326cb5db9158'
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end
end
