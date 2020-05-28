class Rental < ApplicationRecord
  belongs_to :video
  belongs_to :customer

  before_save :default_values
  def default_values
    self.active = true if self.active.nil? 
    #self.due_date ||= self.created_at + 7.day # but created_at is nil! :(
  end
end
