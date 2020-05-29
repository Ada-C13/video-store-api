class Video < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals
  validates :title, :overview, :release_date, presence: true
  validates :total_inventory, presence: true, numericality: { only_integer: true }
  validate :valid_availability

  def videos_checked_out_count
    return rentals.where(returned_on: nil).count
  end

  def available_inventory
    available_inventory = total_inventory - videos_checked_out_count
  end

  private

  def valid_availability
    if total_inventory.nil? 
      errors.add(:available_inventory, "bad data error")
    end
  end
end
