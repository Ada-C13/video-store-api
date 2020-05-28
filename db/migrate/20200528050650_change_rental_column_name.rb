class ChangeRentalColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :rentals, :customers_id, :customer_id
    rename_column :rentals, :videos_id, :video_id
  end
end
