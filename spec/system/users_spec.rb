require 'rails_helper'

describe 'ユーザーのシステムテスト', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com', image: 'inu.png') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com', image: 'inu2.png') }
  let!(:post_a) { FactoryBot.create(:post, content: 'Aの投稿', user: user_a) }

  before do
    visit login_path
    fill_in 'session[email]', with: login_user.email
    fill_in 'session[password]', with: login_user.password
    click_button 'ログイン'
  end

  describe 'ユーザー詳細ページ表示機能' do
    # before do
    #   visit user_path(user_a)
    # end

    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      it 'ユーザーAが作成した投稿が表示される' do
        expect(page).to have_content 'Aの投稿'
      end
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成した投稿が表示されない' do
        expect(page).to have_no_content 'Aの投稿'
      end
    end
  end

  describe 'ユーザー編集機能' do
    let(:login_user) { user_a }

    before do
      visit edit_user_path(user_a)
    end

    it '編集処理' do
      fill_in 'user_name', with: 'ユーザーC'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button '変更'
      expect(page).to have_selector '.alert-success', text: 'プロフィールを更新しました'
    end
  end
end
