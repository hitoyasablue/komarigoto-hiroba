require 'rails_helper'

describe 'ログインのシステムテスト', type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    visit login_path
  end

  context '有効な情報を送信したとき' do
    it 'ユーザーはログインできる' do
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      click_button 'ログイン'
      expect(page).to have_content 'ログインしました'
    end
  end

  context '不正なメールアドレスを送信したとき' do
    it 'ユーザーはログインできない' do
      fill_in 'email', with: 'invalid@invalid.com'
      fill_in 'password', with: user.password
      click_button 'ログイン'
      expect(page).to have_content 'メールアドレス、またはパスワードが正しくありません'
    end
  end

  context '不正なパスワードを送信したとき' do
    it 'ユーザーはログインできない' do
      fill_in 'email', with: user.email
      fill_in 'password', with: 'invalid_password'
      click_button 'ログイン'
      expect(page).to have_content 'メールアドレス、またはパスワードが正しくありません'
    end
  end
end