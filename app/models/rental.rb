class Rental < ApplicationRecord
  belongs_to :video
  belongs_to :customer

  validates :customer_id, presence: true
  validates :video_id, presence: true
  validates :due_date, presence: true
  # validates :customer[:videos_checked_out_count], presence: true
  # validates :video[:available_inventory], presence: true

  def add_to_count
    if self.video.available_inventory < 1
      return ArgumentError("No avaialble copies")
    else
      self.video.available_inventory -= 1
      self.customer.videos_checked_out_count += 1
      self.video.save
      self.customer.save
    end
  end


  def decrease_count
    self.video.available_inventory += 1
    self.customer.videos_checked_out_count -= 1
    self.video.save
    self.customer.save
  end
end
