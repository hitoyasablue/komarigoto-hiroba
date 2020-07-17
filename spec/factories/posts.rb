FactoryBot.define do
  factory :post do
    content { '内容' }
    user
  end
end
