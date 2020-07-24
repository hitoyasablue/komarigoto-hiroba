require 'rails_helper'

describe '「そうなんだ」のシステムテスト', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let!(:post_a) { FactoryBot.create(:post, content: 'Aの投稿', user: user_a) }

  before do
    visit login_path
    fill_in 'session[email]', with: user_a.email
    fill_in 'session[password]', with: user_a.password
    click_button 'ログイン'
  end

  describe '「そうなんだ」表示機能' do
    before do
      visit post_path(post_a)
    end

    context 'すでに投稿に「そうなんだ」をしている場合', js: true do
      before do
        click_button 'そうなんだ'
      end

      it '「そうなんだ済」ボタンが表示されている' do
        expect(page).to have_css '#unlike-button'
      end
    end

    context 'まだ投稿に「そうなんだ」をしていない場合' do
      it '「そうなんだ」ボタンが表示されている' do
        expect(page).to have_css '#like-button'
      end
    end
  end
end
