class Checkout < ApplicationRecord
  validates :video_id, :customer_id, presence :true
  belongs_to :video
  belongs_to :customer
end
