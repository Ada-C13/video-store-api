require "test_helper"

describe RentalsController do
  it "must get index" do
    get rentals_index_url
    must_respond_with :success
  end

  describe 'check_out' do
    before do 
      @customer = customers(:customer1)
      @video = videos(:video1)
    end
    let(:rental_params) {
      {
        customer_id: @customer.id,
        video_id: @video.id,
        due_date: DateTime.current.to_date
      }
    }

    it 'Can chech_out the rental' do
      expect{ post check_out_path, params: rental_params }.must_differ "Rental.count", 1
    
      must_respond_with :ok
      expect(response.header['Content-Type']).must_include 'json'

      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash 
    end

    it "responde with 404 if video dosnt exist" do
      rental_params[:video_id] = nil
      expect{ post check_out_path, params: rental_params}.wont_change "Rental.count"
      must_respond_with :not_found
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body["errors"]).must_equal ["Not Found"]
    end

    it "responde with 404 if customer dosnt exist" do
      rental_params[:customer_id] = nil
      expect{ post check_out_path, params: rental_params}.wont_change "Rental.count"
      must_respond_with :not_found
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body["errors"]).must_equal ["Not Found"]
    end

    it "videos_checked_out_count should get increase by one and available_inventory should get decrease  if we have a check_out " do
      post check_out_path, params: rental_params

      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash

      customer = Customer.find_by(id: @customer.id)
      expect(customer.videos_checked_out_count).must_equal 2 # 1 is in customer fixture

      video = Video.find_by(id: @video.id)
      expect(video.available_inventory).must_equal 8 #9 is in videos fixture
    end

    it 'rental should will create du_date' do
      post check_out_path, params: rental_params
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      rental = Rental.first
      expect(rental.due_date).must_equal DateTime.current.to_date + 7
      must_respond_with :ok
    end
  end

  describe 'check_in' do
    before do 
      @customer = customers(:customer1)
      @video = videos(:video1)
    end
    let(:rental_params) {
      {
        customer_id: @customer.id,
        video_id: @video.id
      }
    }

    it 'Can chech_in the rental' do
      expect{ post check_in_path, params: rental_params}.wont_change "Rental.count"
      must_respond_with :not_found

      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash 
    end
     
    #This test i couldent make it work for som reasone....
    it "videos_checked_out_count should get decrease by one and available_inventory should get increase if we have a check_in " do
      post check_in_path, params: rental_params

      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash

      customer = Customer.find_by(id: @customer.id)
      expect(customer.videos_checked_out_count).must_equal 1 

      video = Video.find_by(id: @video.id)
      expect(video.available_inventory).must_equal 9 
    end

    it "responde with 404 if video dosnt exist" do
      rental_params[:video_id] = nil
      expect{ post check_out_path, params: rental_params}.wont_change "Rental.count"
      must_respond_with :not_found
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body["errors"]).must_equal ["Not Found"]
    end

    it "responde with 404 if customer dosnt exist" do
      rental_params[:customer_id] = nil
      expect{ post check_in_path, params: rental_params}.wont_change "Rental.count"
      must_respond_with :not_found
      expect(response.header['Content-Type']).must_include 'json'
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body["errors"]).must_equal ["Not Found"]
    end
  end
end
