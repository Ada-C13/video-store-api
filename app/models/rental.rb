class Rental < ApplicationRecord
  belongs_to :customer 
  belongs_to :video

  validates :customer_id, presence: true
  validates :video_id, presence: true

  def update_check_out_dates
    self.check_out_date = Date.today
    self.due_date = Date.today + 7
  end


  def update_check_in_date
    self.check_in_date = Date.today
  end

end