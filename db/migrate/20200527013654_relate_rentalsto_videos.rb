class RelateRentalstoVideos < ActiveRecord::Migration[6.0]
  def change
    remove_column :rentals, :video_id
    add_reference :rentals, :video, index: true
  end
end
