class Rental < ApplicationRecord
  belongs_to :video
  belongs_to :customer

  validates :video_id, presence: true
  validates :customer_id, presence: true
  # validates :due_date, presence: true
  # validates :active, presence: true

  before_save :default_values
  def default_values
    self.active = true if self.active.nil? 
    self.due_date = Date.today + 7.day if self.due_date.nil?
  end
end
