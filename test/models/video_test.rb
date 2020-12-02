require "test_helper"

describe Video do
  before do 
    @video = videos(:video_1)
    @customer = customers(:shelley)
      
  end 
  describe "validations" do 
    it "can not create video without title" do 
      @video.title = nil 
      @video.save
      expect(@video.valid?).must_equal false 
      expect(@video.errors.messages[:title]).must_equal ["can't be blank"]
    end 
    it "can not create video without title" do 
      @video.title = nil 
      @video.save
      expect(@video.valid?).must_equal false 
      expect(@video.errors.messages[:title]).must_equal ["can't be blank"]
    end 
    it "can not create video without overview" do 
      @video.overview = nil 
      @video.save
      expect(@video.valid?).must_equal false 
      expect(@video.errors.messages[:overview]).must_equal ["can't be blank"]
    end 
    it "can not create video without release_date" do 
       @video.release_date = nil 
       @video.save
       expect(@video.valid?).must_equal false 
       expect(@video.errors.messages[:release_date]).must_equal ["can't be blank"]
     end 
    it "can not create video without total_inventory" do 
       @video.total_inventory = nil 
       @video.save
       expect(@video.valid?).must_equal false 
       expect(@video.errors.messages[:total_inventory]).must_equal ["can't be blank"]
     end 
    it "can not create video without available_inventory" do 
      @video.available_inventory = nil 
      @video.save
      expect(@video.valid?).must_equal false 
      expect(@video.errors.messages[:available_inventory]).must_equal ["can't be blank"]
    end 
  end 
  describe "relations" do 
    it "can have rentals" do 
      
      rental_one = Rental.create!(customer_id: @customer.id, video_id: @video.id, due_date: Date.today + 7)
      rental_two = Rental.create!(customer_id: @customer.id, video_id: @video.id, due_date: Date.today + 7)
      @video.save
      expect(@video.rentals.size).must_equal 2
    end 
  end 
end
