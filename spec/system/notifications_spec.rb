require 'rails_helper'

describe '通知のシステムテスト', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com', image: 'inu.png') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com', image: 'inu2.png') }
  let!(:post_a) { FactoryBot.create(:post, content: 'Aの投稿', user: user_a) }

  before do
    visit login_path
    fill_in 'session[email]', with: user_b.email
    fill_in 'session[password]', with: user_b.password
    click_button 'ログイン'
    visit post_path(post_a)
  end

  describe '通知一覧ページ表示機能' do
    context '他のユーザーが自分の投稿に「そうなんだ」をしていた場合', js: true do
      before do
        click_button 'そうなんだ'
        click_link 'アカウント'
        click_link 'ログアウト'
        visit login_path
        fill_in 'session[email]', with: user_a.email
        fill_in 'session[password]', with: user_a.password
        click_button 'ログイン'
        visit notifications_path
      end

      it '通知が来ている' do
        expect(page).to have_content 'B さんが この投稿にそうなんだと言っています'
      end
    end

    context '他のユーザーが自分の投稿に「そうなんだ」をしていない場合' do
      before do
        visit notifications_path
      end

      it '通知は来ていない' do
        expect(page).to have_content '通知はありません'
      end
    end
  end
end
