# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Shop.create(
  name: 'hirata',
  email: 'hirata@sqlab.jp',
  password: 'fogefoge'
)

Shop.create(
  name: 'asano',
  email: 'asano@sqlab.jp',
  password: 'fogefoge'
)

(1..100).each do |i|
  Item.create(title: "これは#{i}番目のタイトル", description: "これは#{i}番目の説明", price: i * 1000, shop_id: 1)
  Item.create(title: "これは#{i}番目のタイトルAsano", description: "これは#{i}番目の説明Asano", price: i * 10, shop_id: 2)
end
