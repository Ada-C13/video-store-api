class Rental < ApplicationRecord
  validates :video_id, :customer_id, presence: true
  validates :available_inventory, :videos_checked_out_count, numericality: {greater_than_or_equal_to: 0, only_integer: true }
  belongs_to :video
  belongs_to :customer

  def self.checkout(customer_id: customer_id, video_id: video_id, rental: rental)
    video = Video.find_by(id: video_id)
    customer = Customer.find_by(id:customer_id)

    if video.available_inventory > 0
      video.available_inventory -= 1
      customer.videos_checked_out_count += 1
      video.save!
      customer.save!
      rental.available_inventory = rental.video.available_inventory
      rental.videos_checked_out_count = rental.customer.videos_checked_out_count
    end
    
  end
end
