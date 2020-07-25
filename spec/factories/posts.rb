FactoryBot.define do
  factory :post do
    content { 'テスト投稿' }
    user
  end
end
