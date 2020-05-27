require "test_helper"

describe RentalsController do
  it "must get check-in" do
    # get rentals_check-in_url
    # must_respond_with :success
  end

  describe 'checkout' do 
    it "will create a rental" do

      customer = Customer.first
      video = Video.first

      rental_data = {
        customer_id: customer.id ,
        video_id: video.id
      } 

      expect{post check_out_path, params: rental_data}.must_differ "Rental.count", 1 
      must_respond_with :ok
    end


    it "will return 404 if customer doen't exist and errors details" do 

      customer = Customer.first
      video = Video.first

      rental_data = {
        customer_id: -1, 
        video_id: video.id
      } 

      expect{post check_out_path, params: rental_data}.wont_change "Rental.count"
      
      must_respond_with :not_found 

      body = JSON.parse(response.body)
      expect(body["errors"]).must_include "Not Found"

    end 

    it "will return bad_request if video has 0 inventory" do 

      customer = Customer.first
      video = Video.first
      

      rental_data = {
        customer_id: customer.id, 
        video_id: video.id
      } 

      

      expect{post check_out_path, params: rental_data}.wont_change "Rental.count"

      must_respond_with :bad_request  

      body = JSON.parse(response.body)
      expect(body["errors"]).must_include "No available inventory from video"

    end 
  end   

end
