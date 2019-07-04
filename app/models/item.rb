class Item < ApplicationRecord
  validates :title, presence: true, length: {maximum: 100}
  validates :description, length: {maximum: 500}
  validates :price, numericality: {greater_than_or_equal_to: 0}
end
