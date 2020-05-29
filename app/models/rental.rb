class Rental < ApplicationRecord
  has_many :videos
  has_many :customers

  validates :customer_id, :videos_id, uniqueness: true
end
