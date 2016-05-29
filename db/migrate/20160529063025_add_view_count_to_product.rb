class AddViewCountToProduct < ActiveRecord::Migration
  def change
    change_column :products, :view_counts, :integer, :default => 0
  end
end
