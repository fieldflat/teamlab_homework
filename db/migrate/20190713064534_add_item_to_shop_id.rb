# frozen_string_literal: true

class AddItemToShopId < ActiveRecord::Migration[5.2]
  def change
    add_reference :shops, :shop, foreign_key: true
  end
end
