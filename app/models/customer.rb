class Customer < ApplicationRecord
  has_many :rentals
  has_many :videos, through: :rentals

  validates :name, :registered_at, :address, :city, :state, :postal_code, :phone, presence: true
end
