class Rental < ApplicationRecord
  # validates :check_out_date, presence: true
  # validates :due_date, presence: true

  belongs_to :video
  belongs_to :customer
  
end
