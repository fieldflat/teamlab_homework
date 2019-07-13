class AddPasswordDigestToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :password_digest, :string
  end
end
