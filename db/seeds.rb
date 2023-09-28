# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者ユーザーを作成
admin = User.create!(
  email: 'aaddmmiinn20231001@gmail.com',
  password: 'pa$sw0rd',
  password_confirmation: 'pa$sw0rd',
  nickname: 'Admin',
  prefecture: :tokyo_chuoku,
  admin: true,
  confirmed_at: Time.now
)

# 一般ユーザーを作成
user1 = User.create!(
  email: 'user111@example.com',
  password: 'password',
  password_confirmation: 'password',
  nickname: 'User1',
  prefecture: :tokyo_shinjukuku,
  confirmed_at: Time.now
)

user2 = User.create!(
  email: 'user112@example.com',
  password: 'password',
  password_confirmation: 'password',
  nickname: 'User2',
  prefecture: :kanagawa,
  confirmed_at: Time.now
)