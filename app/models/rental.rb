class Rental < ApplicationRecord
  belongs_to :video
  belongs_to :customer

  validates :customer_id, presence: true
  validates :video_id, presence: true
  validates :due_date, presence: true
  # validates :customer[:videos_checked_out_count], presence: true
  # validates :video[:available_inventory], presence: true

  def add_to_count
    if self.video.available_inventory.nil?
      # chelsea confused here
      self.video.available_inventory = self.video.total_inventory - 1
      self.video.save
      
      self.customer.videos_checked_out_count += 1
      self.customer.save
    else
      self.video.available_inventory -= 1
      self.video.save
      
      self.customer.videos_checked_out_count += 1
      self.customer.save
    end
  end


  def decrease_count
    if self.checked_out != nil
      if self.video.available_inventory == nil   # when would this happen?
        return "This video has not been returned yet"
      else
        self.video.available_inventory += 1
        self.video.save
        
        self.customer.videos_checked_out_count -= 1
        self.customer.save
        self.save
      end
    end
  end
end
