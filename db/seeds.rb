# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'

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
    recruit_status: 0,
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

(1..5).each do |i|
  craftman = Craftman.find_by(user_id: i)
  image_path = Rails.root.join("db/images/craftman_image#{i}.jpg")
  craftman.images.attach(io: File.open(image_path), filename: "craftman_image#{i}.jpg", content_type: "image/jpeg") if craftman
end

(1..5).each do |i|
  candidate = Candidate.find_by(user_id: i)
  image_path = Rails.root.join("db/images/candidate_image#{i}.jpg")
  candidate.images.attach(io: File.open(image_path), filename: "candidate_image#{i}.jpg", content_type: "image/jpeg") if candidate
end

(1..5).each do |i|
  product = Product.find_by(user_id: i)
  image_path = Rails.root.join("db/images/product_image#{i}.jpg")
  product.images.attach(io: File.open(image_path), filename: "product_image#{i}.jpg", content_type: "image/jpeg") if product
end

# Conversations
users = User.first(5)
users.each do |sender|
  users.each do |recipient|
    next if sender == recipient

    Conversation.create(
      sender_id: sender.id,
      recipient_id: recipient.id
    )
  end
end

# Messages
conversations = Conversation.first(5)
users = User.first(5)
conversations.each do |conversation|
  3.times do |i|
    user = users.sample
    Message.create(
      body: "メッセージ#{i + 1} (#{user.name})",
      conversation_id: conversation.id,
      user_id: user.id,
      read: [true, false].sample
    )
  end
end

# Relationships
users = User.first(5)
users.each do |follower|
  users.sample(2).each do |followed|
    next if follower == followed

    # Check if the relationship already exists before creating it
    unless Relationship.exists?(follower_id: follower.id, followed_id: followed.id)
      Relationship.create(
        follower_id: follower.id,
        followed_id: followed.id
      )
    end
  end
end