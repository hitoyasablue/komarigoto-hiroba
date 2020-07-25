require 'rails_helper'

describe User, type: :model do
  context '有効な情報を入力したとき' do
    it '正常に登録される' do
      user = FactoryBot.build(:user)
      expect(user.valid?).to eq(true)
    end
  end

  context '無効な情報を入力したとき' do
    it 'ユーザー名が存在しないためエラーとなる' do
      user = FactoryBot.build(:user, name: nil)
      expect(user.valid?).to eq(false)
    end

    it 'ユーザー名が50文字以下でないためエラーとなる' do
      user = FactoryBot.build(:user, name: "#{'a' * 51}")
      expect(user.valid?).to eq(false)
    end

    it 'メールアドレスが存在しないためエラーとなる' do
      user = FactoryBot.build(:user, email: nil)
      expect(user.valid?).to eq(false)
    end

    it 'メールアドレスに.が入っていないためエラーとなる' do
      user = FactoryBot.build(:user, email: 'a@examplecom')
      expect(user.valid?).to eq(false)
    end

    it 'メールアドレスに@が入っていないためエラーとなる' do
      user = FactoryBot.build(:user, email: 'example.com')
      expect(user.valid?).to eq(false)
    end

    it '入力したメールアドレスを既に他のユーザーが使用しているためエラーとなる' do
      user_a = FactoryBot.create(:user)
      user_b = FactoryBot.build(:user, email: "#{user_a.email}")
      expect(user_b.valid?).to eq(false)
    end

    it 'メールアドレスが255文字以下でないためエラーとなる' do
      user = FactoryBot.build(:user, email: "#{'a' * 250}@example.com")
    end

    it 'パスワードが存在しないためエラーとなる' do
      user = FactoryBot.build(:user, password: nil)
      expect(user.valid?).to eq(false)
    end

    it 'パスワードが6文字以上でないためエラーとなる' do
      user = FactoryBot.build(:user, password: "#{'a' * 5}")
      expect(user.valid?).to eq(false)
    end
  end
end
