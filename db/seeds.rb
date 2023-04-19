# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'

# ゲストユーザー
User.create(
  name: "Guest",
  email: "guest@example.com",
  password: "guest_password",
  role: 2
)

# Users
5.times do |i|
  User.create(
    name: "User#{i + 1}",
    email: "user#{i + 1}@example.com",
    password: "password",
    role: i % 3 # 0, 1, 2, 0, 1
  )
end

# Candidates
5.times do |i|
  Candidate.create(
    user_id: i + 1,
    interested_category: i % 3 + 1,
    wanted_technology: "こんなこと学びたい #{i + 1}",
    prefecture: i % 5 + 1,
    profile: "私は User#{i + 1}です。こんなことに興味があります。 #{i + 1}.",
    name: "User#{i + 1}"
  )
end

# Craftmen
5.times do |i|
  Craftman.create(
    user_id: i + 1,
    category: i % 3 + 1,
    company_name: "会社#{i + 1}",
    prefecture: i % 5 + 1,
    manicipal: "#{i + 1} 市",
    recruit_status: i % 2 + 1,
    recruit_title: "#{i + 1}興味ありませんか？後継者募集時のタイトル",
    recruit_content: "後継者募集の内容です。",
    profile: "#{i + 1}プロフィール、事業者の歴史などです。",
    technology: "#{i + 1}提供できる技術",
    image: nil
  )
end

# Products
5.times do |i|
  Product.create(
    name: "製品#{i + 1}",
    description: "#{i + 1}こちらは製品の紹介です。",
    image: nil,
    user_id: i + 1
  )
end

# Craftmanモデルの画像
(1..5).each do |i|
  craftman = Craftman.find(i)
  image_path = Rails.root.join("db/images/craftman_image#{i}.jpg")
  craftman.images.attach(io: File.open(image_path), filename: "craftman_image#{i}.jpg", content_type: "image/jpeg")
end

# Candidateモデルの画像
(1..5).each do |i|
  candidate = Candidate.find(i)
  image_path = Rails.root.join("db/seeds/candidate_image#{i}.jpg")
  candidate.images.attach(io: File.open(image_path), filename: "candidate_image#{i}.jpg", content_type: "image/jpeg")
end

# Productモデルの画像
(1..5).each do |i|
  product = Product.find(i)
  image_path = Rails.root.join("db/seeds/product_image#{i}.jpg")
  product.images.attach(io: File.open(image_path), filename: "product_image#{i}.jpg", content_type: "image/jpeg")
end

