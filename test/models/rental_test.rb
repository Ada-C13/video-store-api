require "test_helper"

describe Rental do
  describe "relations" do
    before do
      @customer = customers(:jessica)
      @video = videos(:jurassicpark)
      @rental = Rental.create!(customer_id: @customer.id, video_id: @video.id)
    end
    
    it "belongs to one video" do
      expect(@rental.video).must_be_instance_of Video
      expect(@rental.video).must_equal @video
    end

    it "belongs to one customer" do
      expect(@rental.customer).must_be_instance_of Customer
      expect(@rental.customer).must_equal @customer
    end
  end
end
