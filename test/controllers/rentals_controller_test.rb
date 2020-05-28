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
     check_response(expected_type: Hash, expected_status: :ok)
    end

    it "returns not_found if video or customer empty" do
      rental_params[:customer_id] = nil
      expect{post check_out_path, params: rental_params}.wont_change "Rental.count", 1
      check_response(expected_type: Hash, expected_status: :not_found)
    end

    it "customer  video checked out count changes" do
      post check_out_path, params: rental_params
      updated_checkout_count = Rental.find_by(customer_id: customers(:customer1).id)
      expect(updated_checkout_count.videos_checked_out_count).must_equal 2
    end

    it "available video count changes" do
      post check_out_path, params: rental_params
      updated_available_count = Rental.find_by(video_id: videos(:video1).id)
      expect(updated_available_count.available_inventory).must_equal 8
    end

    it "can return not_found when no video is in stock" do
      video3 = videos(:video3)
      video3.available_inventory = 0
      video3.save!
     
      expect{post check_out_path, params: {customer_id: customer.id, video_id: video3.id }}.wont_change "Rental.count", 1
      check_response(expected_type: Hash, expected_status: :not_found)
    end
  end
  
  describe "check_in" do
    before do 
      post check_out_path, params: rental_params
    end
    it "can successfully check-in" do
      expect{post check_in_path, params: rental_params}.wont_change "Rental.count", 1
      check_response(expected_type: Hash, expected_status: :ok)
    end

    it "returns not found if video or customer nil" do
      rental_params[:customer_id] = nil
      expect{post check_in_path, params: rental_params}.wont_change "Rental.count", 1
      check_response(expected_type: Hash, expected_status: :not_found)
    end

    it "can decrease changes customers checked out and also increase the videos inventory" do
      
      current_video_count = Rental.find_by(video_id: videos(:video1).id).available_inventory
      current_customer_count = Rental.find_by(customer_id: customers(:customer1).id).videos_checked_out_count

      post check_in_path, params: rental_params

      updated_current_video_count = Rental.find_by(video_id: videos(:video1).id)
      updated_current_customer_count = Rental.find_by(customer_id: customers(:customer1).id)

      expect(updated_current_customer_count.videos_checked_out_count).must_equal 1
      expect(updated_current_video_count.available_inventory).must_equal 9
    end

    it "can delete existing checkout" do
      exisiting_rental = Rental.find_by(customer_id: customer.id)
      post check_in_path, params: rental_params

      find_existing = Rental.find_by(id: exisiting_rental.id)
      assert_nil(find_existing)
    end 

  end
end
