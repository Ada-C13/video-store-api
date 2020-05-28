class AddColumnsToVideos < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :title, :string
    add_column :videos, :overview, :string
    add_column :videos, :release_date, :string
    add_column :videos, :total_inventory, :integer
    add_column :videos, :available_inventory, :integer
  end
end
