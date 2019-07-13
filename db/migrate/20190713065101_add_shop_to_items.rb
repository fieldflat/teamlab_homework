class AddShopToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :shop, foreign_key: true
  end
end
