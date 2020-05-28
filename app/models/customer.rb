class Customer < ApplicationRecord
	has_many :rentals
	has_many :videos, through: :rentals

	def check_out_increase 
		self.videos_checked_out_count += 1
		self.save
	end

	def check_in_decrease 
		self.videos_checked_out_count -= 1
		self.save
	end
end
