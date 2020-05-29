require "test_helper"

describe RentalsController do
  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_instance_of expected_type
    return body
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
        due_date: Date.today
      }
    }
    
    it 'should respond with success' do
      expect{ post checkout_path, params: rental_params }.must_differ "Rental.count", 1
    
      check_response(expected_type: Hash)
    end

    it "should increase the customer's videos_checked_out_count by one" do
      post checkout_path, params: rental_params
      customer = Customer.find_by(id: @customer.id)
      check_response(expected_type: Hash)
      expect(customer.videos_checked_out_count).must_equal 2
    end

    it "should decrease the video's available_inventory by one" do
      # decrease the video's available_inventory by one
      post checkout_path, params: rental_params
      video= Video.find_by(id: @video.id)
      check_response(expected_type: Hash)
      expect(video.available_inventory).must_equal 8
    end

    it 'should create a due date' do
      # create a due date. The rental's due date is the seven days from the current date
      post checkout_path, params: rental_params
      rental = Rental.first
      check_response(expected_type: Hash)
      expect(rental.due_date).must_equal Date.today + 7
    end

    # # edge case
    it "should responde with 404 if customer does not exist" do 
      rental_params[:customer_id] = -1
      post checkout_path, params: rental_params
      must_respond_with :not_found

      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body['errors']).must_equal ['Not Found']
      expect{ post checkout_path, params: rental_params }.wont_differ ("Rental.count")
      
    end 

    it "should responde with 404 if video does not exist" do 
      rental_params[:video_id] = -1
      post checkout_path, params: rental_params
      must_respond_with :not_found

      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body['errors']).must_equal ['Not Found']
      expect{ post checkout_path, params: rental_params }.wont_differ ("Rental.count")
    end

    it "should not create a check_out if the customer wants to rental a video where its available_inventory is 0 " do
      @video.available_inventory = 0
      @video.save
      post checkout_path, params: rental_params
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body['errors']).must_equal ["Bad Request. There is no video available."]
      expect{post checkout_path, params: rental_params}.wont_differ 'Rental.count'
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
    
    it 'should respond with success' do

      expect{ post checkin_path, params: rental_params }.wont_differ "Rental.count"
    
      check_response(expected_type: Hash)
    end

    it "should decrease the customer's videos_checked_in_count by one" do
      post checkin_path, params: rental_params
      customer = Customer.find_by(id: @customer.id)
      check_response(expected_type: Hash)
      expect(customer.videos_checked_out_count).must_equal 0
    end

    it "should increase the video's available_inventory by one" do
      post checkin_path, params: rental_params
      video = Video.find_by(id: @video.id)
      check_response(expected_type: Hash)
      expect(video.available_inventory).must_equal 10
    end

  #   # # edge case
    it "should responde with 404 if customer does not exist" do 
      rental_params[:customer_id] = -1
      post checkin_path, params: rental_params
      must_respond_with :not_found

      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body['errors']).must_equal ['Not Found']
      expect{ post checkin_path, params: rental_params }.wont_differ ("Rental.count")
      
    end 

    it "should responde with 404 if video does not exist" do 
      rental_params[:video_id] = -1
      post checkin_path, params: rental_params
      must_respond_with :not_found

      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body['errors']).must_equal ['Not Found']
      expect{ post checkin_path, params: rental_params }.wont_differ ("Rental.count")
    end
  end
end