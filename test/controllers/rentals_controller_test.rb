 require "test_helper"

describe RentalsController do

  describe "checkout" do
    before do 
    customer = Customer.first
    video = Video.first
   
    @rental_data = {
          customer_id: customer.id,
          video_id: video.id,
          due_date: Date.today + 7.days
    }
    end

    it "responds with JSON and success" do
      post check_out_path, params: @rental_data

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :created
    end
 
    it "responds with id" do
      # Act
      post check_out_path, params: @rental_data
    
      # Get the body of the response
      body = JSON.parse(response.body)
    
      # Assert
      expect(body).must_be_instance_of Hash
      expect(body[:id]).is_a? Integer
      end
    
  end
end


