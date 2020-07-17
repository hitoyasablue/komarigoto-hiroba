require 'rails_helper'

describe 'ログインのシステムテスト', type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    visit login_path
  end

  context '有効な情報を送信した場合' do
    before do
      fill_in 'login_email', with: user.email
      fill_in 'login_password', with: user.password
      click_button 'ログイン'
    end

    it 'ユーザーはログインできる' do
      expect(page).to have_content 'ログインしました'
    end
  end

  context '不正なメールアドレスを送信した場合' do
    before do
      fill_in 'login_email', with: 'invalid@invalid.com'
      fill_in 'login_password', with: user.password
      click_button 'ログイン'
    end

    it 'ユーザーはログインできない' do
      expect(page).to have_content 'メールアドレス、またはパスワードが正しくありません'
    end
  end

  context '不正なパスワードを送信した場合' do
    before do
      fill_in 'login_email', with: user.email
      fill_in 'login_password', with: 'invalid_password'
      click_button 'ログイン'
    end
    it 'ユーザーはログインできない' do
      expect(page).to have_content 'メールアドレス、またはパスワードが正しくありません'
    end
  end
end
