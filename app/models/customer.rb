class Customer < ApplicationRecord
  #relationships
  
  validates :name, presence: true 
  validates :registered_at, presence: true 
  validates :postal_code, presence: true
  validates :address, presence: true 
  validates :city, presence: true 
  validates :state, presence: true 
  validates :phone, presence: true 
  validates :videos_checked_out_count, presence: true 
end
