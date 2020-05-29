require "test_helper"

describe RentalsController do
  
  RENTAL_FIELDS = ['available_inventory', 'videos_checked_out_count', 'customer_id', 'video_id', 'due_date'].sort
  
  let(:customer) {
    customers(:junito)
  }
  
  let(:video) {
    videos(:brazil)
  }
  
  describe "check_out" do 
    
    it "can get checkout path, creates a new rental with valid information and responds with success" do       
      rental_info = {
        customer_id: customer.id,
        video_id: video.id
      }
      
      count = customer.videos_checked_out_count
      vid_count = video.available_inventory
      
      expect {
        post check_out_path(params: rental_info)
      }.must_differ "Rental.count", 1
      customer.reload
      video.reload
      
      body = JSON.parse(response.body)
      
      must_respond_with :success
      expect(response.header['Content-Type']).must_include 'json'
      expect(body.keys.sort).must_equal RENTAL_FIELDS
      expect(body["due_date"]).must_equal (Date.today + 7).to_s
      expect(body["customer_id"]).must_equal customer.id
      expect(body["video_id"]).must_equal video.id
      expect(body["videos_checked_out_count"]).must_equal customer.videos_checked_out_count
      expect(body["available_inventory"]).must_equal video.available_inventory
      
      expect(customer.videos_checked_out_count).must_equal count + 1
      expect(video.available_inventory).must_equal vid_count - 1
      
    end 
    
    it "responds with not_found if customer is nil" do
      rental_info = {
        customer_id: 'pizza',
        video_id: video.id
      }
      
      expect {
        post check_out_path, params: rental_info
      }.wont_change "Rental.count"
      
      body = JSON.parse(response.body)
      
      must_respond_with :not_found
      expect(body).must_be_instance_of Hash 
      expect(body['errors']).must_equal ['Not Found']
    end
    
    
    
    it "responds with not_found if video is nil" do
      rental_info = {
        customer_id: customer.id,
        video_id: 'sandwich',
      }
      
      expect {
        post check_out_path, params: rental_info
      }.wont_change "Rental.count"
      
      body = JSON.parse(response.body)
      
      must_respond_with :not_found
      expect(body).must_be_instance_of Hash 
      expect(body['errors']).must_equal ['Not Found']
    end
    
    it 'responds with bad_request if there are no videos available' do
      
      video = Video.create(
        title: "A Cool Movie",
        release_date: "2020-01-02",
        available_inventory: 0,
        total_inventory: 0,
        overview: "The best movie you've ever seen"
      )
      
      rental_info = {
        customer_id: customer.id,
        video_id: video.id,
      }
      
      
      expect {
        post check_out_path, params: rental_info
      }.wont_change "Rental.count"
      
      
      body = JSON.parse(response.body)
      
      must_respond_with :bad_request
      expect(body).must_be_instance_of Hash 
      
      
      
    end
    
  end 
  
  describe "check_in" do 
    it "can get check_in path and responds with success" do       
      
      rental_info = {
        customer_id: customer.id,
        video_id: video.id
      }
      
      post check_out_path(params: rental_info)
      
      customer.reload
      video.reload
      
      cust_count = customer.videos_checked_out_count
      vid_count = video.available_inventory
      
      expect {      
        post check_in_path(params: rental_info)
      }.must_differ "Rental.count", -1
      
      
      body = JSON.parse(response.body)
      
      must_respond_with :success
      expect(response.header['Content-Type']).must_include 'json'
      expect(body["customer_id"]).must_equal customer.id
      expect(body["video_id"]).must_equal video.id
      expect(body["videos_checked_out_count"]).must_equal cust_count - 1
      expect(body["available_inventory"]).must_equal vid_count + 1
    end 
    
    it "returns detailed error and status 404 if cust does not exist" do 
      rental_info = {
        customer_id: 'Pizza',
        video_id: video.id
      }
      
      expect {      
        post check_in_path(params: rental_info)
      }.wont_change "Rental.count"
      
      body = JSON.parse(response.body)

      must_respond_with :not_found 
      expect(body['errors']).must_equal ['Not Found']
      
    end 
    
    it "returns detailed error and status 404 if video does not exist" do 
      rental_info = {
        customer_id: customer.id,
        video_id: 'Pasta'
      }
      
      expect {      
        post check_in_path(params: rental_info)
      }.wont_change "Rental.count"
      
      body = JSON.parse(response.body)

      must_respond_with :not_found 
      expect(body['errors']).must_equal ['Not Found']
    end 
    
    it "returns an error if a video is tried to check in multiple times" do 
      rental_info = {
        customer_id: customer.id,
        video_id: video.id
      }
      
      post check_out_path(params: rental_info)
      
      post check_in_path(params: rental_info)
      
      customer.reload
      video.reload
      
      cust_count = customer.videos_checked_out_count
      vid_count = video.available_inventory
      
      expect {      
        post check_in_path(params: rental_info)
      }.wont_change "Rental.count"
      
      body = JSON.parse(response.body)
      
      must_respond_with :bad_request
      
      expect(customer[:videos_checked_out_count]).must_equal cust_count
      expect(video[:available_inventory]).must_equal vid_count
      expect(body['errors']).must_equal ['Rental not valid']
      
    end 
    
  end
  
end