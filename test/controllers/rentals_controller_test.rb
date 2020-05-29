require "test_helper"

describe RentalsController do
  before do 
    @customer = customers(:shelley)
    @video = videos(:joker)
  end 

  let(:rental) {
    {
      customer_id: @customer.id,
      video_id: @video.id
    }
  }

  let(:invalid_rental) {
    {
      customer_id: @customer.id,
      video_id: videos(:avatar).id # Avatar has 0 available videos (see videos.yml)
    }
  }

   # helper method
   def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "checkout" do 
    # Success Cases
    it "returns 200 status for request with valid params" do 
      # Act
      post checkout_path, params: rental

      # Assert
      check_response(expected_type: Hash, expected_status: :ok)
    end 

    it "creates rental object for a request with valid params" do 
      # Act - Assert
      expect{post checkout_path, params: rental}.must_differ "Rental.count", 1
    end  

    it "increase the customer's videos_checked_out_count by one" do 
      # Act
      post checkout_path, params: rental
      @customer.reload

      # Assert 
      expect(@customer.videos_checked_out_count).must_equal 2
    end 

    it "decrease the video's available_inventory by one" do 
      # Act
      post checkout_path, params: rental
      @video.reload
      
      # Assert 
      expect(@video.available_inventory).must_equal 3
    end 

    it "creates a due date that is the seven days from the current date." do 
      # Act
      post checkout_path, params: rental

      # Assert
      body = check_response(expected_type: Hash, expected_status: :ok)

      expect(body["due_date"]).must_equal (Date.today + 7).strftime("%Y-%m-%d")
    end 

    # Error Cases 
    it "should return back detailed errors and a status 404: Not Found if the customer does not exist" do 
      # Arrange
      invalid_customer_id = -1
      invalid_data = {customer_id: invalid_customer_id, video_id: @video.id}

      # Act
      post checkout_path, params: invalid_data

     # Assert 
      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["errors"]).must_include "Not Found"
    end 

    it "should return back detailed errors and a status 404: Not Found if the video does not exist" do 
      # Arrange
      invalid_video_id = -1
      invalid_data = {customer_id: @customer.id, video_id: invalid_video_id}

      # Act 
      post checkout_path, params: invalid_data

      # Assert
      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["errors"]).must_include "Not Found"
    end 

    it "should return back detailed errors and a status 400: Bad Request if the video does not have any available inventory before check out" do 
      # Act
      post checkout_path, params: invalid_rental

      # Assert
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body["errors"]).must_include "Video currently not available"
    end 
  end 

  describe "checkin" do 
    # Success Cases 
    it "returns 200 status for request with valid params" do 
      # Act
      post checkin_path, params: rental

      # Assert
      check_response(expected_type: Hash, expected_status: :ok)
    end 

    it "decreases the customer's videos_checked_out_count by one" do 
      # Act
      post checkout_path, params: rental
      @customer.reload

      # Assert 
      expect(@customer.videos_checked_out_count).must_equal 0
    end 

    it "increases the video's available_inventory by one" do 
      # Act
      post checkin_path, params: rental
      @video.reload
      
      # Assert 
      expect(@video.available_inventory).must_equal 5
    end 

    # Error Cases
    it "should return back detailed errors and a status 404: Not Found if the customer does not exist" do 
      # Arrange
      invalid_customer_id = -1
      invalid_data = {customer_id: invalid_customer_id, video_id: @video.id}

      # Act
      post checkout_path, params: invalid_data

     # Assert 
      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["errors"]).must_include "Not Found"
    end 
    
    it "should return back detailed errors and a status 404: Not Found if the video does not exist" do 
      # Arrange
      invalid_video_id = -1
      invalid_data = {customer_id: @customer.id, video_id: invalid_video_id}

      # Act 
      post checkin_path, params: invalid_data

      # Assert
      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["errors"]).must_include "Not Found"
    end 
  end 
end
