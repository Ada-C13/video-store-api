class Rental < ApplicationRecord
  has_many :videos
  has_many :customers

end
