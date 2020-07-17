require 'rails_helper'

describe '投稿のシステムテスト', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:post_a) { FactoryBot.create(:post, content: 'おめシスはいいぞ', user: user_a) }

  before do
    visit login_path
    fill_in 'session[email]', with: login_user.email
    fill_in 'session[password]', with: login_user.password
    click_button 'ログイン'
  end

  shared_examples_for 'ユーザーAが作成した投稿が表示される' do
    it { expect(page).to have_content 'おめシスはいいぞ' }
  end

  describe '一覧表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      it_behaves_like 'ユーザーAが作成した投稿が表示される'
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).to have_no_content 'おめシスはいいぞ'
      end
    end
  end

  describe '詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit post_path(post_a)
      end

      it_behaves_like 'ユーザーAが作成した投稿が表示される'
    end
  end

  describe '新規投稿機能' do
    let(:login_user) { user_a }

    before do
      visit new_post_path
      fill_in 'content', with: post_content
      click_button '投稿'
    end

    context '新規作成画面で内容を入力したとき' do
      let(:post_content) { 'こんにちにんにん' }

      it '正常に登録される' do
        expect(page).to have_selector '.alert-success', text: '投稿しました'
      end
    end

    context '新規作成画面で内容を入力しなかったとき' do
      let(:post_content) { '' }

      it 'エラーとなる' do
        within '#error_explanation' do
          expect(page).to have_content '内容を入力してください'
        end
      end
    end
  end
end
