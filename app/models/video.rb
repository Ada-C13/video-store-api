class Video < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, :overview, :release_date, presence: true
  validates :total_inventory, presence: true, numericality: { only_integer: true }

  def videos_checked_out_count
    return self.rentals.where(returned_on: nil).count
  end

  def available_inventory
    return total_inventory - videos_checked_out_count
  end

end
