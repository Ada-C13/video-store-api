class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :video

  validates :due_date, presence: true
  validates :checkout_date, presence: true
  validates :video_id, presence: true
  validates :customer_id, presence: true
end
