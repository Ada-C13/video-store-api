class Video < ApplicationRecord
    validates :title, :overview, :release_date, :total_inventory, :available_inventory,  presence: true 
    has_many :rentals
    has_many :customers, through: :rentals
end
