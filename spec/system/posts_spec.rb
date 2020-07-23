require 'rails_helper'

describe '投稿のシステムテスト', type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  let!(:post_a) { FactoryBot.create(:post, content: 'Aの投稿', user: user_a) }
  let!(:post_b) { FactoryBot.create(:post, content: 'Bの投稿', user: user_b) }

  before do
    visit login_path
    fill_in 'session[email]', with: login_user.email
    fill_in 'session[password]', with: login_user.password
    click_button 'ログイン'
  end

  shared_examples_for 'ユーザーAが作成した投稿が表示される' do
    it { expect(page).to have_content 'Aの投稿' }
  end

  describe 'ユーザー詳細ページ表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      # before do
      #   visit user_path(user_a)
      # end

      it_behaves_like 'ユーザーAが作成した投稿が表示される'
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user) { user_b }

      # before do
      #   visit user_path(user_a)
      # end

      it 'ユーザーAが作成した投稿が表示されない' do
        expect(page).to have_no_content 'Aの投稿'
      end
    end
  end

  describe '新規投稿機能' do
    let(:login_user) { user_a }

    before do
      visit new_post_path
      fill_in 'post_content', with: post_content
      click_button '投稿'
    end

    context '新規作成画面で内容を入力したとき' do
      let(:post_content) { '困っています！' }

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

  describe '投稿一覧ページ表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit posts_path
      end

      it 'ユーザーA,Bが作成したタスクが表示される' do
        expect(page).to have_content 'Aの投稿'
        expect(page).to have_content 'Bの投稿'
      end
    end
  end

  describe '投稿詳細ページ表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit post_path(post_a)
      end

      it_behaves_like 'ユーザーAが作成した投稿が表示される'
    end
  end

  describe '投稿編集機能' do
    let(:login_user) { user_a }

    before do
      visit post_path(post_a)
      click_link '編集'
    end

    it '投稿の編集処理' do
      fill_in 'post_content', with: 'Aの投稿更新成功！'
      click_button '更新'
      expect(page).to have_selector '.alert-success', text: '投稿を更新しました'
    end
  end

  describe '投稿削除機能' do
    let(:login_user) { user_a }

    before do
      visit post_path(post_a)
      click_link '削除'
    end

    it '投稿の削除処理' do
      expect(page).to have_selector '.alert-success', text: '投稿を削除しました'
    end
  end

  describe '投稿検索機能' do
    let(:login_user) { user_a }

    before do
      visit posts_path
    end

    context 'いずれかの投稿内容と一致する検索ワードを送信した場合' do
      before do
        fill_in 'search_word', with: 'Aの'
        click_button '検索'
      end

      it '検索結果が表示される' do
        expect(page).to have_content 'Aの投稿'
      end
    end

    context 'どの投稿内容とも一致しない検索ワードを送信した場合' do
      before do
        fill_in 'search_word', with: 'Cの'
        click_button '検索'
      end

      it '検索結果は1件も表示されない' do
        expect(page).to have_content '一致する困りごとはありません'
      end
    end
  end
end
