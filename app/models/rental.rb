class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :video

  validates :customer_id, :video_id, :due_date, :checkout_date, presence: true

  def checkout_update(date)
    self.checkout_date = date
    self.due_date = date + 7
  end

  def checkedin?
    return checkin_date.nil?
  end

  def checkin_update(date)
    checkin_date = date
    self.save
  end
end
