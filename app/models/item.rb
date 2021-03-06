# frozen_string_literal: true

class Item < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  mount_uploader :image, ImageUploader
  belongs_to :shop
end
