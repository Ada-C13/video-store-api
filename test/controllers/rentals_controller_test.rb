require "test_helper"

describe RentalsController do
  before do 
    @customer = customers(:shelley)
    @video = videos(:joker)
  end 

  let(:rental) {
    {
      customer_id: @customer.id
      video_id: @video.id
    }
  }


  describe "checkout" do 
    # success cases
    it "creates rental object and returns 200 status for request with valid params" do 
      expect{post checkout_path, params: rental}.must_differ "Rental.count", 1
      must_respond_with :ok
    end  

    it "increase the customer's videos_checked_out_count by one" do 
      new_rental = Rental.new(rental)

      expect(@customer.videos_checked_out_count).must_equal 2
    end 

    it "decrease the video's available_inventory by one" do 
      new_rental = Rental.new(rental)

      expect(@video.available_inventory).must_equal 4
    end 

    it "creates a due date that is the seven days from the current date." do 
      # Act
      post checkout_path, params: rental

      # Assert
      body = JSON.parse(response.body)
      expect(body["due_date"]).must_equal Date.now + 7
    end 

    # error cases 
    it "should return back detailed errors and a status 404: Not Found if the customer does not exist" do 
      # Arrange
      invalid_customer_id = -1
      invalid_data = {customer_id: invalid_customer_id, video_id: @video.id.id}
      # Act - Assert
      expect{post checkout_path, params: invalid_data}.must_respond_with :not_found

      body = JSON.parse(response.body)
      expect(body["errors"]).must_include "Not Found"
    end 

    it "should return back detailed errors and a status 404: Not Found if the video does not exist" do 
      # Arrange
      invalid_video_id = -1
      invalid_data = {customer_id: @customer.id, video_id: invalid_video_id

      # Act - Assert
      expect{post checkout_path, params: invalid_data}.must_respond_with :not_found

      body = JSON.parse(response.body)
      expect(body["errors"]).must_include "Not Found"
    end 

    it "should return back detailed errors and a status 400: Bad Request if the video does not have any available inventory before check out" do 
      # Arrange
      @video.available_inventory = 0

      # Act - Assert
      expect{post checkout_path, params: rental}.must_respond_with :bad_request

      body = JSON.parse(response.body)
      expect(body["errors"]).must_include "Video currently not available"
      
    end 
  end 

  describe "checkin" do 

  end 
end
