require 'rails_helper'

describe '投稿のシステムテスト'
describe '一覧表示機能' do
  before do
    user_a = FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com')
    FactoryBot.create(:post, content: 'おめシスはいいぞ',user: user_a)
  end
  context 'ユーザーAがログインしているとき' do
    before do
      visit login_path
      fill_in 'session[email]', with: 'a@example.com'
      fill_in 'session[password]', with: 'password'
      click_button 'ログイン'
    end

    it 'ユーザーAが投稿した困りごとが表示される' do
      expect(page).to have_content 'おめシスはいいぞ'
    end
  end
end
