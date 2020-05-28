require "test_helper"

describe RentalsController do
  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "create" do
    let(:rental_data) {
      {
        video_id: videos(:frozen).id,
        customer_id: customers(:nataliya).id
      }
    }

    it "can create a rental" do
      expect{post rentals_path, params: rental_data}.must_differ "Rental.count", 1
      check_response(expected_type: Hash)
    end

    it "increase the customer's videos_checked_out_count by one" do
      expect(customers(:nataliya).videos_checked_out_count).must_equal 6
      
      post rentals_path, params: rental_data
      expect(customers(:nataliya).videos_checked_out_count).must_equal 7
    end


      
    end
  end
end
