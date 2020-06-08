class Rental < ApplicationRecord
  has_a :video
  has_a :customer
  validates :customer_id, :video_id, :due_date presence: :true
end
