class Video < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals

  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  # To-DO: validate against available_inventory
  validates :total_inventory, presence: true, numericality: { only_integer: true }

  def videos_checked_out_count
    return rentals.where(returned_on: nil).count
  end

  def available_inventory
    return total_inventory - videos_checked_out_count
  end

  

end
