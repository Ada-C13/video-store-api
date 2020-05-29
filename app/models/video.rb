class Video < ApplicationRecord
  has_many :rentals
  validates :title, presence: true, length: { minimum: 1, maximum: 200 }
  validates :overview, presence: true, length: { minimum: 1, maximum: 1000 }
  validates :release_date, presence: true, format: { with: /\d{4}-\d{2}-\d{2}/, message: "must be in YYYY-MM-DD format"}
  validates :total_inventory, presence: true, numericality: { only_integer: true, message: "must be integer" }
  validates :available_inventory, presence: true, numericality: { only_integer: true, message: "must be integer" }
end
