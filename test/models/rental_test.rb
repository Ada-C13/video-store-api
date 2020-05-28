require "test_helper"

describe Rental do
  describe "validations" do 
    before do 
      @customer = Customer.new(name: "Daenerys Targaryen", address: "some big house", registered_at: Date.parse("28 May 2020"), city: "Valyria", state: "Essos", postal_code: "98122")
      @video = Video.new(title: "Legally Blonde", overview: "Elle Woods becomes a lawyer", release_date: Date.parse("13 July 2001"), total_inventory: 6, available_inventory: 5)
      @rental = Rental.new(customer_id: @customer.id, video_id: @video.id, checkout_date: Date.today, due_date: Date.today + 7)
    end
    
    it "has a customer id" do
      expect(@rental.customer_id).must_equal @customer.id
    end
    
    it "is invald without a customer id" do
      @rental.customer_id = nil
      
      expect(@rental.valid?).must_equal false
    end
    
    it "has a movie id" do
      expect(@rental.video_id).must_equal @video.id
    end

    it "is invald without a video id" do
      @rental.video_id = nil

      expect(@rental.valid?).must_equal false
    end
  end
end
