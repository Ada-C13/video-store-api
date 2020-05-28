class Video < ApplicationRecord
  has_many :rentals
  has_many :customers, through: :rentals
  validates :title, :overview, :total_inventory, :available_inventory, :release_date, presence: true
  validates :total_inventory, :available_inventory, numericality: { only_integer: true }

  def check_availability
    return self.available_inventory > 0
  end

  def decrease_inventory
    self.available_inventory -= 1
    self.save
  end
end
