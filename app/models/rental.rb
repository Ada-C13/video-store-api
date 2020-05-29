class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :video

  # def is_overdue
  #   if Date.today > rental.due_date
  #     self.is_overdue = true
  #     self.save
  #   end
  # end
end
