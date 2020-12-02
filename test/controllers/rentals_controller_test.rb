require "test_helper"

describe RentalsController do
  before do
    @customer = customers(:shelley)
    @video = videos(:video_1)
    @rental = Rental.create!(customer_id: @customer.id, video_id: @video.id, due_date: Date.today + 7)
    @rental_params = {
      customer_id: @customer.id,
      video_id: @video.id
    }
  end
  describe "checkout" do 
    
    it "can create a rental for valid input and responds with ok" do 
     
      expect { post checkout_path, params: @rental_params }.must_differ "Rental.count", 1
      must_respond_with :ok
      expect(response.header['Content-Type']).must_include 'json'
    end 
    it "returns a bad request when inventory is 0 before rental checkout" do 
      @video.available_inventory = 0 
      @video.save 
      expect { post checkout_path, params: @rental_params }.wont_change "Rental.count"
      must_respond_with :bad_request
      expect(response.header['Content-Type']).must_include 'json'
    end 
    it "returns not_found when video is not found for rental" do
      rental_params = {
        customer_id: @customer.id,
        video_id: -1
      }
      expect { post checkout_path, params: rental_params }.wont_change "Rental.count"
      must_respond_with :not_found
      expect(response.header['Content-Type']).must_include 'json'
    end
    it "returns not_found when customer is not found for rental" do
      rental_params = {
        customer_id: -3,
        video_id: @video.id
      }
      expect { post checkout_path, params: rental_params }.wont_change "Rental.count"
      must_respond_with :not_found
      expect(response.header['Content-Type']).must_include 'json'
    end
  end 

  describe "checkin" do
   
    it "returns 200 ok status and correct json when checking in an existing valid rental" do
      expect { post checkin_path, params: @rental_params }.wont_differ "Rental.count"
      must_respond_with :ok
    end 

    it "returns 200 ok status and correct json when checking in an existing valid rental" do
      check_in_fields = ["customer_id", "video_id", "videos_checked_out_count", "available_inventory"].sort
      expect{ post checkin_path, params: @rental_params }.wont_change "Rental.count"
      check_in_fields = ["customer_id", "video_id", "videos_checked_out_count", "available_inventory"].sort

      shelley_rental_params = {
        customer_id: @customer.id,
        video_id: @video.id
      }

      post checkout_path, params: shelley_rental_params

      expect{ post checkin_path, params: shelley_rental_params }.wont_change "Rental.count"
      must_respond_with :ok
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal check_in_fields
    end
    
    it "returns not found if the rental params are invalid: invalid customer_id" do
      invalid_rental_params = {
        customer_id: -1,
        video_id: 2
      }

      expect{ post checkin_path, params: invalid_rental_params }.wont_change "Rental.count"
      must_respond_with :not_found
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body['errors']).must_equal ['Not Found']
    end

    it "returns not found if the rental params are invalid: invalid video_id" do
      invalid_rental_params = {
        customer_id: 1,
        video_id: -5
      }

      expect{ post checkin_path, params: invalid_rental_params }.wont_change "Rental.count"
      must_respond_with :not_found
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body['errors']).must_equal ['Not Found']
    end
  end
end