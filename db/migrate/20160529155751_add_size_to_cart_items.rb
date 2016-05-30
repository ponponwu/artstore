class AddSizeToCartItems < ActiveRecord::Migration
  def change
    add_column :cart_items, :size, :integer
  end
end
