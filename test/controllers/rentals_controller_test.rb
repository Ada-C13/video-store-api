require "test_helper"

describe RentalsController do
  describe "check out" do 

    it "will create a rental" do 
      customer = customers(:shelley)
      customer.save 
      video = videos(:vid1)
      video.save 

      rental_data = {
        customer_id: customer.id, 
        video_id: video.id
      }
    
      expect {
        post check_out_path, params: rental_data
      }.must_differ "Rental.count", 1
      
      must_respond_with :ok
    end 

    it "will not check out if there are no available videos" do 
      customer = customers(:shelley)
      customer.save 
      video = videos(:vid3)
      video.save 

      rental_data = {
        customer_id: customer.id, 
        video_id: video.id
      }

      expect {
        post check_out_path, params: rental_data
      }.must_differ "Rental.count", 0

      must_respond_with :bad_request

      body = JSON.parse(response.body) 

      expect(body).must_be_instance_of Hash
      expect(body["errors"][0]).must_equal "No Inventory Available"
    end 

    it "will have the correct due date" do 
      customer = customers(:shelley)
      customer.save 
      video = videos(:vid1)
      video.save 

      rental_data = {
        customer_id: customer.id, 
        video_id: video.id
      }
      expect {
        post check_out_path, params: rental_data
      }.must_differ "Rental.count", 1
      rental = Rental.first

      expect(rental.due_date.to_s).must_include "2020"
    end 
  end   

  describe "check in" do
    before do
      @customer = customers(:shelley)
      @video = videos(:vid2)
      @rental_data = {
        customer_id: @customer.id, 
        video_id: @video.id
      }
    end

    it "does not change the Rental count" do
      # Arrange, Act
      post check_out_path, params: @rental_data
      # # Assert
      expect{ post check_in_path, params: @rental_data }.wont_change "Rental.count"
      must_respond_with :ok
    end
  
    it "updates the data in the database" do
      # Arrange
      post check_out_path, params: @rental_data
      checked_out_count = @customer.reload.videos_checked_out_count
      available_inventory = @video.reload.available_inventory
      # Act
      post check_in_path, params: @rental_data
      # Assert
      must_respond_with :ok
      expect( @customer.reload.videos_checked_out_count).must_equal checked_out_count - 1
      expect(@video.reload.available_inventory).must_equal available_inventory + 1
    end

    it "returns not_found if there is no checked out rental instance" do
      # Arrange, Act
      post check_in_path, params: @rental_data
      # Assert
      must_respond_with :not_found
    end

    it "returns not_found if customer id is missing" do
      # Arrange, Act
      post check_out_path, params: @rental_data
      must_respond_with :ok
      @rental_data[:customer_id] = nil
      post check_in_path, params: @rental_data
      body = JSON.parse(response.body) 
      # Assert
      must_respond_with :not_found
      expect(body["errors"][0]).must_equal "Not Found"
    end
  end
end
