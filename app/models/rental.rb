class Rental < ApplicationRecord
  belongs_to :video
  belongs_to :customer

  def due_date
    return created_at + 7.days
  end

end
