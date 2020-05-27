class Customer < ApplicationRecord
  # validates :name, presence: true, uniqueness:{scope: :phone, message: 'Customer already exists in database'}
  # validates :registered_at, :address, :city, :postal_code, :phone, presence: true
  validates :videos_checked_out_count, numericality: {greater_than_or_equal_to: 0, only_integer: true }
  has_many :rentals
  has_many :videos, through: :rentals

end
