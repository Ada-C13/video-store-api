require "test_helper"

describe Rental do

  before do
    @customer = customers(:jessica)
    @video = videos(:jurassicpark)
    @rental = Rental.create!(customer_id: @customer.id, video_id: @video.id)
  end

  describe "relations" do
    it "belongs to one video" do
      expect(@rental.video).must_be_instance_of Video
      expect(@rental.video).must_equal @video
    end

    it "belongs to one customer" do
      expect(@rental.customer).must_be_instance_of Customer
      expect(@rental.customer).must_equal @customer
    end
  end

  describe "due_date" do
    it "returns a Date that is 7 days from today" do
      expect(@rental.due_date).must_be_instance_of Date
      expect(@rental.due_date - Date.today).must_equal 7
    end
  end
end