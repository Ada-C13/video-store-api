class Rental < ApplicationRecord
  has_and_belongs_to_many :customers
  has_and_belongs_to_many :videos
end
