class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :video

  def due_date
    return Date.today + 7
  end
end
