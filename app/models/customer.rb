class Customer < ApplicationRecord
  has_many :rentals

  validates :name, :registered_at, :address, :city, :state, :postal_code, :phone, presence: true
  
end
