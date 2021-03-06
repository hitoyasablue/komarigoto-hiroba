require 'rails_helper'

describe 'ユーザー登録のシステムテスト', type: :system do
  let(:user) { FactoryBot.create(:user) }

  before do
    visit new_user_path
    fill_in 'user_name', with: '井上'
    fill_in 'user_email', with: 'inoue@example.com'
    fill_in 'user_password', with: 'inoueinoue'
    fill_in 'user_password_confirmation', with: 'inoueinoue'
  end

  context '有効な情報を送信した場合' do
    before do
      click_button '登録'
    end

    it 'ユーザー登録ができる' do
      expect(page).to have_content 'ログインしました'
    end
  end

  context 'ニックネームを入力しなかった場合' do
    before do
      fill_in 'user_name', with: ''
      click_button '登録'
    end

    it 'ユーザー登録ができない' do
      expect(page).to have_selector '#error_explanation', text: 'ニックネームを入力してください'
    end
  end

  context '不正なメールアドレスを入力した場合' do
    before do
      fill_in 'user_email', with: 'invalid_email'
      click_button '登録'
    end

    it 'ユーザー登録ができない' do
      expect(page).to have_selector '#error_explanation', text: 'メールアドレスは不正な値です'
    end
  end

  context '無効なパスワードを入力した場合' do
    before do
      fill_in 'user_password', with: 'a'
      fill_in 'user_password_confirmation', with: 'a'
      click_button '登録'
    end

    it 'ユーザー登録ができない' do
      expect(page).to have_selector '#error_explanation', text: 'パスワードは6文字以上で入力してください'
    end
  end
end
