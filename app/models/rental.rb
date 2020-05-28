class Rental < ApplicationRecord
  validates :video_id, :customer_id, presence: true
  validates :available_inventory, :videos_checked_out_count, numericality: {greater_than_or_equal_to: 0, only_integer: true }
  belongs_to :video
  belongs_to :customer

  def checkout
    video = Video.find_by(id: self.video.id)
    customer = Customer.find_by(id: self.customer.id)

    if video.available_inventory > 0
      video.decrease_available_inventory.reload
      customer.increase_checked_out.reload
      self.due_date = Date.today + 7
      self.available_inventory = video.available_inventory
      self.videos_checked_out_count = customer.videos_checked_out_count
      return self
    end
    
  end

  def checkin
    video = Video.find_by(id: self.video.id)
    customer = Customer.find_by(id: self.customer.id)

    video.increase_available_inventory
    customer.decrease_checked_out

    rental = Rental.new(video_id: video.id, customer_id: customer.id)
    rental.available_inventory = rental.video.available_inventory
    rental.videos_checked_out_count = rental.customer.videos_checked_out_count
    return rental
  end
end
