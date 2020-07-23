require 'rails_helper'

describe '進捗のシステムテスト', type: :system do
  before do
    visit login_path
    fill_in 'session[email]', with: login_user.email
    fill_in 'session[password]', with: login_user.password
    click_button 'ログイン'
  end
end
