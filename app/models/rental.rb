class Rental < ApplicationRecord
  belongs_to :videos
  belongs_to :customers
end
