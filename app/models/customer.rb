class Customer < ApplicationRecord
  has_many :rentals
  has_many :vidoes, through: :rentals 
end
