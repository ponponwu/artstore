class AddViewCountsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :view_counts, :integer, :default => 0
  end
end
