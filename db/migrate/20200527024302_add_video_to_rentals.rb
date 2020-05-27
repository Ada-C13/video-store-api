class AddVideoToRentals < ActiveRecord::Migration[6.0]
  def change
    add_reference :rentals, :video, index: true
    add_foreign_key :rentals, :videos
  end
end
