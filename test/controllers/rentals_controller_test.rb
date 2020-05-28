require "test_helper"

describe RentalsController do

  describe "check_out" do 

    let(:customer) {
      customers(:pengsoo)
    }
    let(:video) {
      videos(:parasite)
    }

    let(:rental_data) {
      {
        customer_id: customer.id,
        video_id: video.id
      }
    }

    it "can enables a customer to check out" do 
      # Arrange
      inventory_nums = video.available_inventory 
      checked_out_video_nums = customer.videos_checked_out_count 
      

      # Act & Assert
      expect {
        post check_out_path, params: rental_data
      }.must_differ "Rental.count", 1

      must_respond_with :success 

      expect(response.header['Content-Type']).must_include 'json'

      # Arrange
      rental = Rental.find_by(video_id: video.id, customer_id: customer.id)

      # Act & Assert
      expect(rental.check_out_date).must_equal Time.now.strftime('%Y-%m-%d')

      expect(Video.find(video.id).available_inventory).must_equal inventory_nums - 1
      expect(Customer.find(customer.id).videos_checked_out_count).must_equal checked_out_video_nums + 1
    end


    it "a customer cannot checkout if given an invalid video_id" do 

      rental_data[:video_id] = -1

      checked_out_video_nums = customer.videos_checked_out_count 

      expect {
        post check_out_path, params: rental_data
      }.wont_change "Rental.count"

      must_respond_with :not_found

      expect(response.header['Content-Type']).must_include 'json'


      expect(Customer.find(customer.id).videos_checked_out_count).must_equal checked_out_video_nums
    end

    it "a customer cannot checkout if given an invalid customer_id" do 

      rental_data[:customer_id] = -1

      inventory_nums = video.available_inventory 

      expect {
        post check_out_path, params: rental_data
      }.wont_change "Rental.count"

      must_respond_with :not_found

      expect(response.header['Content-Type']).must_include 'json'


      expect(Video.find(video.id).available_inventory).must_equal inventory_nums
    end

    it "a customer cannot checkout if video inventory is 0" do 
      video_us = videos(:us)

      new_rental_params = {
        customer_id: customer.id,
        video_id: video_us.id
      }

      # Arrange
      inventory_nums = video_us.available_inventory 
      checked_out_video_nums = customer.videos_checked_out_count 


      expect {
        post check_out_path, params: new_rental_params
      }.wont_change "Rental.count"

      must_respond_with :bad_request

      expect(response.header['Content-Type']).must_include 'json'

      expect(Customer.find(customer.id).videos_checked_out_count).must_equal checked_out_video_nums
      expect(Video.find(video_us.id).available_inventory).must_equal inventory_nums
    end
  end

  describe "check_in" do 

    let(:customer) {
      customers(:pengsoo)
    }
    let(:video) {
      videos(:parasite)
    }

    let(:rental_params) {
      {
        customer_id: customer.id,
        video_id: video.id
      }
    }

    before do # important!
      post check_out_path, params: rental_params
    end

    it "can enables a customer to check in" do  

      # Arrange
      inventory_nums = video.available_inventory 
      checked_out_video_nums = customer.videos_checked_out_count

      
      # Act & Assert
    
      expect {
        post check_in_path, params: rental_params
      }.wont_change "Rental.count"

      must_respond_with :success 

      expect(response.header['Content-Type']).must_include 'json'


      # Arrange
      rental = Rental.find_by(video_id: video.id, customer_id: customer.id)

      # Act & Assert
      expect(rental.check_in_date).must_equal Time.now.strftime('%Y-%m-%d')

      expect(Video.find(video.id).available_inventory).must_equal inventory_nums
      expect(Customer.find(customer.id).videos_checked_out_count).must_equal checked_out_video_nums
    end

    it "a customer cannot check in if given an invalid video_id" do  

      # Arrange
      rental_params[:video_id] = -1

      expect {
        post check_in_path, params: rental_params
      }.wont_change "Rental.count"

      must_respond_with :not_found

      expect(response.header['Content-Type']).must_include 'json'
    end

    it "a customer cannot check in if given an invalid customer_id" do  

      # Arrange
      rental_params[:customer_id] = -1

      checked_out_video_nums = customer.videos_checked_out_count 

      expect {
        post check_in_path, params: rental_params
      }.wont_change "Rental.count"

      must_respond_with :not_found

      expect(response.header['Content-Type']).must_include 'json'
    end
  end
end
