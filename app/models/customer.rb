class Customer < ApplicationRecord
  validates :name, presence: true, uniqueness:{scope: :phone, message: 'Customer already exists in database'}
  validates :registered_at, :address, :city, :postal_code, :phone, presence: true
  has_many :videos , dependent: :nullify
end
