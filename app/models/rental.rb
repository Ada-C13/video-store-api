class Rental < ApplicationRecord
  belongs_to :customer
  belongs_to :video

  # def self.create_checkout
  #   new_checkout_params = {
  #     due_date: self.due_date
  #   }
  # end

  # def self.due_date
  #   return Date.today + 7.days
  # end
end
