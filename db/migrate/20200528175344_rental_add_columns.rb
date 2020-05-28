class RentalAddColumns < ActiveRecord::Migration[6.0]
  def change
    add_column :rentals, :customer_id, :bigint
    add_column :rentals, :video_id, :bigint
    
    add_index :rentals, :customer_id
    add_index :rentals, :video_id
  end
end
