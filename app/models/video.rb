class Video < ApplicationRecord
  has_many :rentals

  validates :title, presence: true
  validates :release_date, presence: true
  validates :available_inventory, presence: true, numericality: { only_integer: true }
  validates :total_inventory, presence:true, numericality: true
  #TODO double check that total inventory validations are made
end
