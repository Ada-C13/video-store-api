class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :video

  def self.inventory_check_out(rental) 
    customer = Customer.find_by(id: rental.customer_id)
    video = Video.find_by(id: rental.video_id)

    if video.available_inventory > 0 && customer && video
       customer.videos_checked_out_count += 1 
       customer.save
       video.available_inventory -= 1
       video.save
      return true 
    else
      return false 
    end 
  end 

  def self.inventory_check_in(rental) 
    customer = Customer.find_by(id: rental.customer_id)
    video = Video.find_by(id: rental.video_id)

    if customer && video
       customer.videos_checked_out_count -= 1 
       video.available_inventory += 1
       return true 
    else
       return false 
    end 
  end 

end
