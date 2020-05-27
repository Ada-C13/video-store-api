class Customer < ApplicationRecord

  has_many :videos

  validates :name, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true
  validates :phone, presence: true
  validates :phone, numericality: true
  validates :registered_at, presence: true

end
