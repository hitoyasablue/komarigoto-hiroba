require 'rails_helper'

describe '「えらい」のシステムテスト', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let!(:post_a) { FactoryBot.create(:post, content: 'Aの投稿', user: user_a) }
  let!(:progress_a) { FactoryBot.create(:progress, content: 'Aの進捗', post: post_a) }

  before do
    visit login_path
    fill_in 'session[email]', with: user_a.email
    fill_in 'session[password]', with: user_a.password
    click_button 'ログイン'
  end

  describe '「えらい」表示機能' do
    before do
      visit post_progress_path(post_a, progress_a)
    end

    context 'すでに投稿に「えらい」をしている場合', js: true do
      before do
        click_button 'えらい'
      end

      it '「えらい済」ボタンが表示されている' do
        expect(page).to have_css '#unerai-button'
      end
    end

    context 'まだ投稿に「えらい」をしていない場合' do
      it '「えらい」ボタンが表示されている' do
        expect(page).to have_css '#erai-button'
      end
    end
  end
end
