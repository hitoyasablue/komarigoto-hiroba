require 'rails_helper'

describe Progress, type: :model do
  context '有効な情報が入力されたとき' do
    it '正常に登録される' do
      progress = FactoryBot.build(:progress)
      expect(progress.valid?).to eq(true)
    end
  end

  context '無効な情報が入力されたとき' do
    it '内容が存在しないためエラーとなる' do
      progress = FactoryBot.build(:progress, content: nil)
      expect(progress.valid?).to eq(false)
    end
  end
end
