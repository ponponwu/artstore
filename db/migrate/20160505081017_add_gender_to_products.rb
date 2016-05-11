class AddGenderToProducts < ActiveRecord::Migration
  def change
    add_column :products, :gender, :integer
    add_index :products, :gender
  end
end
