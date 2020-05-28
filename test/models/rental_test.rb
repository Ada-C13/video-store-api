require "test_helper"

describe Rental do
  describe "self.inventory_check_out" do
    it "will return true if valid customer and video" do
      customer = customers(:shelley)
      customer.save 
      video = videos(:vid1)
      video.save 
      date = DateTime.now + 1.week

      rental = Rental.new(due_date: date, customer_id: customer.id, video_id: video.id)

      answ = Rental.inventory_check_out(rental)

      expect(answ).must_equal true 
    end

    it "will return flase if for invalid customer" do
      video = videos(:vid1)
      video.save 
      date = DateTime.now + 1.week
      rental = Rental.new(due_date: date, customer_id: 1000, video_id: video.id)
      answ = Rental.inventory_check_out(rental)
      expect(answ).must_equal false 
    end

    it "will decrement video availibility and will increment customer videos" do 
      customer = customers(:shelley)
      customer.save 
      video = videos(:vid1)
      video.save 
      date = DateTime.now + 1.week

      rental = Rental.new(due_date: date, customer_id: customer.id, video_id: video.id)
      
      answ = Rental.inventory_check_out(rental)

      
      video.reload
      customer.reload
      expect(answ).must_equal true
      
      expect(video.available_inventory).must_equal 1
      expect(customer.videos_checked_out_count).must_equal 2
    end 
  end

  describe "self.inventory_check_in" do
    before do
      @customer = customers(:shelley)
      @video = videos(:vid1)
      date = DateTime.now + 1.week
      @rental = Rental.new(due_date: date, customer_id: @customer.id, video_id: @video.id)
    end

    it "will return true for valid customer and video" do
      answer = Rental.inventory_check_in(@rental)
      expect(answer).must_equal true 
    end

    it "will return false for invalid customer and video" do
      @rental.customer = nil
      answer = Rental.inventory_check_in(@rental)
      expect(answer).must_equal false 

      @rental.video = nil
      answer = Rental.inventory_check_in(@rental)
      expect(answer).must_equal false 
    end

    it "decreases the customer's videos and increases the video's available_inventory" do
      videos_checked_out_count = @customer.videos_checked_out_count
      available_inventory = @video.available_inventory
      Rental.inventory_check_in(@rental)
      expect(@customer.reload.videos_checked_out_count).must_equal videos_checked_out_count - 1
      expect(@video.reload.available_inventory).must_equal available_inventory + 1
    end
  end
end
