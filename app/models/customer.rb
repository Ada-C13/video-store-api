class Customer < ApplicationRecord 
    validates :name, :phone, :registered_at, presence: true 
    has_many :rentals
    has_many :videos, through: :rentals
end
