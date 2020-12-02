require "test_helper"

describe Rental do
  before do 
    @rental = rentals(:rental_1)
    @customer = customers(:shelley)
    @video = videos(:video_1)
  end 
  describe "validations" do 
    it "can create a rental with all the required fields" do
      new_rental = Rental.create!(customer_id: @customer.id, video_id: @video.id, due_date: Date.today)
      expect(new_rental.valid?).must_equal true
    end
    it "can not create rental without due_date" do 
      @rental.due_date = nil 
      expect(@rental.valid?).must_equal false 
      expect(@rental.errors.messages[:due_date]).must_equal ["can't be blank"]
    end 
  end 
  describe "relations" do 
    it "will have customer_id" do 
      new_rental = Rental.new(customer_id: @customer.id, video_id: @video.id)
      new_rental.save
      expect(new_rental.customer_id).must_equal @customer.id
    end 
    it "will have video_id" do 
      new_rental = Rental.new(customer_id: @customer.id, video_id: @video.id)
      new_rental.save
      expect(new_rental.video_id).must_equal @video.id
    end 
  end 
  describe "increment_videos_checked_out_count" do 
    it "can increment videos checked out and descrement_videos_checked_out_count" do 
      new_customer = Customer.create!(
        name: "Shelley Rocha",
        registered_at: "Wed, 29 Apr 2015 07:54:14 -0700",
        phone: "(322) 510-8695",
        videos_checked_out_count: 0
        )
      expect(new_customer.videos_checked_out_count).must_equal 0 
      new_rental = Rental.create!(customer_id: new_customer.id, video_id: @video.id, due_date: Date.today + 7)
      new_customer.reload
      @video.reload
      expect(new_customer.videos_checked_out_count).must_equal 1

      new_rental.decrement_videos_checked_out_count
      new_customer.reload 

      expect(new_customer.videos_checked_out_count).must_equal 0 
    end 
  end 
  describe "decrement_available_inventory" do 
    it "can decrement_available_inventory and increment_available_inventory" do 
      expect(@video.available_inventory).must_equal 8
      new_rental = Rental.create!(customer_id: @customer.id, video_id: @video.id, due_date: Date.today + 7)
      @customer.reload
      @video.reload
      expect(@video.available_inventory).must_equal 7
      
      new_rental.increment_available_inventory
      @video.reload 
      expect(@video.available_inventory).must_equal 8
    end
  end 
end
