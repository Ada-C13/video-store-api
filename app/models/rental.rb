class Rental < ApplicationRecord
	belongs_to :customer
	belongs_to :video

	validates :customer_id, presence: true 
	validates :video_id, presence: true
	validates :due_date, presence: true
end
