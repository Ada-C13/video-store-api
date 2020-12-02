class Rental < ApplicationRecord
    validates :due_date, presence: true 
    belongs_to :customer
    belongs_to :video

# Model methods with help from Sharon Cheung
    after_create :increment_videos_checked_out_count, :decrement_available_inventory

    def increment_videos_checked_out_count
        self.customer.videos_checked_out_count += 1
        self.customer.save
        return self.customer.videos_checked_out_count 
    end   

    def decrement_available_inventory
        self.video.available_inventory -= 1
        self.video.save
        return self.video.available_inventory
    end

    def decrement_videos_checked_out_count
        self.customer.videos_checked_out_count -= 1
        self.customer.save
        return self.customer.videos_checked_out_count
    end
    
    def increment_available_inventory
        self.video.available_inventory += 1
        self.video.save
        return self.video.available_inventory
    end

    

    
end



