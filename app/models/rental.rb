class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :video

  validates :video_id, presence: true
  validates :customer_id, presence: true
  
  def set_due_date
   self.due_date = DateTime.now + 1.week
  end
  def set_videos_checked_out_count
    self.customer.checked_out_video
    self.videos_checked_out_count = self.customer.videos_checked_out_count
  end
  def set_available_inventory
    self.video.checked_out
    self.available_inventory = self.video.available_inventory
  end
  def check_out
    set_due_date
    set_videos_checked_out_count
    set_available_inventory
  end
  
  def set_check_in_date
    check_in_date = DateTime.now
  end
  def restore_available_inventory
    self.video.checked_in
    self.available_inventory = self.video.available_inventor
  end
  def restore_videos_checked_out_count
    self.customer.checked_in_video
    self.videos_checked_out_count = self.customer.videos_checked_out_count
  end
  def checked_in
    set_check_in_date
    restore_available_inventory
    restore_videos_checked_out_count
  end

end


