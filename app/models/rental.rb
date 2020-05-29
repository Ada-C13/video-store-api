class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :video

  validates :video_id, presence: true
  validates :customer_id, presence: true
  
  def set_due_date
    return self.created_at + 1.week
  end

  def set_check_in_date
    check_in_date = DateTime.now
  end

end
