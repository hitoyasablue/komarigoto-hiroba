User.create!(name: 'admin',
  email: 'admin@example.com',
  password: 'adminadmin',
  password_confirmation: 'adminadmin',
  admin: true)

100.times do |n|
  Post.create!(content: "#{n}コメ", user_id: 1)
end
