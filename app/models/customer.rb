class Customer < ApplicationRecord
  has_many :rentals

  validates :name, :registered_at, :postal_code, :phone, presence: true
  
end
