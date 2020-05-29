class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.string :title
      t.date :release_date
      t.integer :available_inventory
      t.integer :total_inventory
      t.string :overview 
      t.timestamps
    end
  end
end
