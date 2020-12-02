require "test_helper"

describe Customer do
  before do 
    @customer = customers(:shelley)
    @video = videos(:video_1)
  end 
  describe "validations" do 
    
    it "can not create customer without name" do 
      @customer.name = nil 
      @customer.save
      expect(@customer.valid?).must_equal false 
      expect(@customer.errors.messages[:name]).must_equal ["can't be blank"]
    end 
    it "can not create customer without phone" do 
      @customer.phone = nil 
      @customer.save 
      expect(@customer.valid?).must_equal false 
      expect(@customer.errors.messages[:phone]).must_equal ["can't be blank"]
    end 
    it "can not create customer without registered_at" do 
      @customer.registered_at = nil 
      @customer.save 
      expect(@customer.valid?).must_equal false 
      expect(@customer.errors.messages[:registered_at]).must_equal ["can't be blank"]
    end 
    
  end 

  describe "Relations" do 
    it "can have multiple rentals" do 
      rental_one = Rental.create!(customer_id: @customer.id, video_id: @video.id, due_date: Date.today + 7)
      rental_two = Rental.create!(customer_id: @customer.id, video_id: @video.id, due_date: Date.today + 7)
      @customer.save
      expect(@customer.rentals.size).must_equal 2
    end 
    
  end 

end
