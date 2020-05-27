class Rental < ApplicationRecord
  belongs_to :video
  belongs_to :customer

  def add_to_count
 
   self.video.available_inventory -= 1
   self.customer.videos_checked_out_count += 1
   self.save

  end
end
