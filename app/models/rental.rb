class Rental < ApplicationRecord
  belongs_to :video
  belongs_to :customer
  validates :customer_id, :video_id, :due_date, presence: :true
end
