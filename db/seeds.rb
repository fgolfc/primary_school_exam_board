# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者ユーザーを作成
admin = User.create!(
  email: ENV['ADMIN_EMAIL'],
  password: ENV['ADMIN_PASSWORD'],
  password_confirmation: ENV['ADMIN_PASSWORD'],
  nickname: 'Admin',
  prefecture: :tokyo_chuoku,
  admin: true,
  confirmed_at: Time.now
)

# 一般ユーザーを作成
user1 = User.create!(
  email: ENV['USER1_EMAIL'],
  password: ENV['USER1_PASSWORD'],
  password_confirmation: ENV['USER1_PASSWORD'],
  nickname: 'User1',
  prefecture: :tokyo_shinjukuku,
  confirmed_at: Time.now
)

user2 = User.create!(
  email: ENV['USER2_EMAIL'],
  password: ENV['USER2_PASSWORD'],
  password_confirmation: ENV['USER2_PASSWORD'],
  nickname: 'User2',
  prefecture: :kanagawa,
  confirmed_at: Time.now
)
