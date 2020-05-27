require "test_helper"

describe RentalsController do
  let(:customer){
    customers(:customer1)
  }
  let(:video){
    videos(:video1)
  }
  let(:rental_params){
    {
    customer_id: customer.id,
    video_id: video.id,
    }
  }

  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "checkout" do
    it "creates a new rental"do
     expect{post check_out_path, params: rental_params}.must_differ "Rental.count", 1
     check_response(expected_type: Hash, expected_status: :created)
    end
    it "returns bad request if video or customer empty" do
      rental_params[:customer_id] = nil
      expect{post check_out_path, params: rental_params}.wont_change "Rental.count", 1
      check_response(expected_type: Hash, expected_status: :bad_request)
    end

    it "customer  video checked out count changes" do
      post check_out_path, params: rental_params
      updated_checkout_count = Customer.find_by(id: customers(:customer1).id)
      expect(updated_checkout_count.videos_checked_out_count).must_equal 2
    end

    it "available video count changes" do
      post check_out_path, params: rental_params
      updated_available_count = Video.find_by(id: videos(:video1).id)
      expect(updated_available_count.available_inventory).must_equal 8
    end

    it "can return bad request when no video is in stock" do
      video3 = videos(:video3)
      video3.available_inventory = 0
      video3.save!
     
      expect{post check_out_path, params: {customer_id: customer.id, video_id: video3.id }}.wont_change "Rental.count", 1
      check_response(expected_type: Hash, expected_status: :bad_request)
    end

  end

  
end
