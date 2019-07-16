# frozen_string_literal: true

class RemoveShopIdFromShops < ActiveRecord::Migration[5.2]
  def change
    remove_reference :shops, :shop, foreign_key: true
  end
end
