class AddNameToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :name, :string
    add_index :brands, :name , unique: true
  end
end
