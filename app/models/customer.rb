class Customer < ApplicationRecord
  validates :name, presence: true

  has_many :rentals
  has_many :videos, :through => :rentals
end

