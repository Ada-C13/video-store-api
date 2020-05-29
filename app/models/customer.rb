class Customer < ApplicationRecord
    has_many :rentals
    validates :name, presence:true
    validates :phone, presence:true

    def increase_videos_checked_out_count
      #customer = Customer.find_by(id: customer_id)
      self.videos_checked_out_count += 1
      self.save
    end

    def decrease_videos_checked_out_count
        self.videos_checked_out_count -= 1
        self.save
    end
end
