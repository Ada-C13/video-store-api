class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :video

  def update_inventory 
    customer = Customer.find_by(id: self.customer_id)
    video = Video.find_by(id: self.video_id)
    if !customer.nil? && !video.nil? && video.available_inventory > 0
      customer.videos_checked_out += 1 
      video.available_inventory -= 1
      return true 
    else
      return false 
    end 
  end 

end
