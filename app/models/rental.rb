class Rental < ApplicationRecord
    belongs_to :customer
    belongs_to :video

    def self.decrease_inventory
        video = Video.find_by(id: video_id)
        video.available_inventory -= 1
        video.save
    end

    def increase_videos_checked_out_count
        customer = Customer.find_by(id: customer_id)
        customer.videos_checked_out_count += 1
        customer.save
    end
end
