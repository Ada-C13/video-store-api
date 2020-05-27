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


  after_create :increment_videos_checked_out_count, :decrement_available_inventory

  private

  def increment_videos_checked_out_count
    self.customer.increment(:videos_checked_out_count, 1).save
  end

  def decrement_available_inventory
    self.video.decrement(:available_inventory, 1).save
  end
end
