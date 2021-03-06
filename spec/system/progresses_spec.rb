require 'rails_helper'

describe '返信のシステムテスト', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com', image: 'inu.png') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com', image: 'inu2.png') }
  let!(:post_a) { FactoryBot.create(:post, content: 'Aの投稿', user: user_a) }
  let!(:progress_a) { FactoryBot.create(:progress, content: 'Aの返信その1', content_2: 'Aの返信その2', post: post_a) }

  before do
    visit login_path
    fill_in 'session[email]', with: login_user.email
    fill_in 'session[password]', with: login_user.password
    click_button 'ログイン'
  end

  describe '返信記録機能' do
    let(:login_user) { user_a }

    before do
      visit post_path(post_a)
      click_button 'その後の返信を記録する'
    end

    context '内容を入力して記録ボタンを押した場合' do
      it '正常に記録される' do
        fill_in 'progress_content', with: 'こういう返信がありました！'
        fill_in 'progress_content_2', with: 'こういう返信もありました！'
        click_button '返信を記録'
        expect(page).to have_selector '.alert-success', text: '返信を投稿しました！'
      end
    end

    context '内容を入力せずに記録ボタンを押した場合' do
      it 'エラーメッセージが表示される' do
        fill_in 'progress_content', with: ''
        click_button '返信を記録'
        expect(page).to have_content '必須項目1を入力してください'
      end
    end
  end

  describe '返信詳細ページ表示機能' do
    let(:login_user) { user_a }

    before do
      visit post_path(post_a)
    end

    it 'ユーザーAが作成した返信が表示される' do
      expect(page).to have_content 'Aの返信その1'
    end
  end

  describe '返信編集機能' do
    let(:login_user) { user_a }

    before do
      visit post_progress_path(post_a, progress_a)
      click_link '編集'
    end

    context '内容を入力して更新ボタンを押した場合' do
      it '正常に更新される' do
        fill_in 'progress_content', with: 'Aの返信更新成功！'
        click_button '更新'
        expect(page).to have_selector '.alert-success', text: '返信を更新しました'
      end
    end

    context '内容を入力せずに更新ボタンを押した場合' do
      it 'エラーメッセージが表示される' do
        fill_in 'progress_content', with: ''
        click_button '更新'
        expect(page).to have_content '必須項目1を入力してください'
      end
    end
  end

  describe '投稿削除機能' do
    let(:login_user) { user_a }

    before do
      visit post_progress_path(post_a, progress_a)
      click_link '削除'
    end

    it '投稿の削除処理' do
      expect(page).to have_selector '.alert-success', text: '返信を削除しました'
    end
  end
end
