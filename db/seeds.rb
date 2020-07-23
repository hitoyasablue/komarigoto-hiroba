User.create!(name: 'admin',
  email: 'admin@example.com',
  password: 'adminadmin',
  password_confirmation: 'adminadmin',
  admin: true)

User.create!(name: 'テストユーザー',
  email: 'test@example.com',
  password: 'testtest',
  password_confirmation: 'testtest',
  admin: false)

100.times do |n|
  Post.create!(content: "#{n}コメ", user_id: 1)
end
