require "test_helper"

describe Rental do
  before do 
    @rental = Rental.new(customer_id: 1, video_id: 2)
  end
  describe "valid creation" do
    it "must have assigned fields" do 
      expect(@rental.customer_id).must_equal 1
      expect(@rental.video_id).must_equal 2
    end

    it "must be connected to customer" do
      customer = Customer.create(
        name: "Shelley Rocha",
        registered_at: "Wed, 29 Apr 2015 07:54:14 -0700",
        address: "Ap #292-5216 Ipsum Rd.",
        city: "Hillsboro",
        state: "OR",
        postal_code: "24309",
        phone: "(322) 510-8695",
        videos_checked_out_count: 1
      )
      @rental.customer = customer
      expect(@rental.customer.id).must_equal customer.id
    end

    it "must be connected to video" do
      video = Video.create(
        title: "Rats and Birds And Strangers",
        overview: "The childhood enemy claims the woman is heir to an incredible fortune, all paperwork has been taken care of already, all there's left to do is sign them. Distrustful of both this situation and of this childhood friend, the woman somewhat gladly agrees to the proposal, but there's no time to waste, a decision had to be made quickly.",
        release_date: "2012-09-26",
        total_inventory: 2,
        available_inventory: 2
      )
      expect(@rental.video.id).must_equal video.id
    end
    
    it "must be valid" do 
      result = @rental.valid?
      expect(result).must_equal true
    end
  end
  describe "presence validation" do
    it "is invalid if customer_id is missing" do
      @rental.customer_id = nil
      result = @rental.valid?
      expect(result).must_equal false
    end
    it "is invalid if video_id is missing" do
      @rental.video_id = nil
      result = @rental.valid?
      expect(result).must_equal false
    end
    
  end
  
end
