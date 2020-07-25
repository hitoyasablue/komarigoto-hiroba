require 'rails_helper'

describe Post, type: :model do
  context '有効な情報が入力されたとき' do
    it '正常に登録できる' do
      post = FactoryBot.build(:post)
      expect(post.valid?).to eq(true)
    end
  end

  context '無効な情報が入力されたとき' do
    it '内容が存在しないためエラーとなる' do
      post = FactoryBot.build(:post, content: nil)
      expect(post.valid?).to eq(false)
    end
  end
end
