require "test_helper"

describe RentalsController do

  describe "checkin" do
    it "finds the correct customer and video ids for checking in an existing valid rental" do
    end

    it "returns 200 ok status and json when checking in an existing valid rental" do
    end

    it "decreases the customer's videos_checked_out count by 1 for a valid rental" do
    end

    it "increases the video's available count by 1 for a valid rental" do
    end

    it "sets the rental's returned status to be true for a valid rental" do
    end

    it "returns error message and 404 not_found for a rental with a customer that does not exist" do
    end

    it "returns error message and 404 not_found for a rental with a video that does not exist" do
    end


  end

  # TODO FILL IN THESE TESTS
  # describe "set_customer" do
  #   it "correctly finds an existing valid customer" do
  #     customer = customers(:shelley)

  #     expect(self.set_customer).must_equal customer

  #   end

  #   it "returns json with an error message if the customer could not be found" do
  #   end
  # end

  # describe "set_video" do
  #   it "correctly finds and existing valid video" do
  #   end

  #   it "returns json with an error message if the video could not be found" do
  #   end
  # end
end
