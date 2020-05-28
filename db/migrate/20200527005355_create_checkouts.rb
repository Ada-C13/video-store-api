class CreateCheckouts < ActiveRecord::Migration[6.0]
  def change
    create_table :checkouts do |t|
      t.integer :customer_id
      t.integer :video_id
      t.date :due_date
      t.integer :videos_checked_out_count
      t.integer :available_inventory

      t.timestamps
    end
  end
end
