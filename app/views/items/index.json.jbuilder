# frozen_string_literal: true

# json.array! @items, :id, :title, :description, :price, :image
json.array! @items do |item|
  json.id item.id
  json.title item.title
  json.description item.description
  json.price item.price
  json.image item.image
  json.shop_name item.shop.name
end
