class Rental < ApplicationRecord
  belongs_to :video
  belongs_to :customer

  validate :inventory_available, on: :create

  def due_date
    return created_at + 7.days
  end

  private

  def inventory_available
    if video.available_inventory <= 0 
      self.errors[:message] << "no inventory available"
    end
  end
end
