class Video < ApplicationRecord
  validates :title, :overview, :total_inventory, :available_inventory, :release_date, presence: true
end
