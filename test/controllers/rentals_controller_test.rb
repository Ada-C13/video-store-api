require "test_helper"

describe RentalsController do

  REQUIRED_ATTRS = ["customer_id", "video_id", "due_date"].sort

  describe "check out" do
    let(:check_out_data) {
      {
        rental: {
          customer_id: customers(:customer_one).id,
          video_id: videos(:fake_vid).id,
        }
      }
    }

    it "creates a rental checkout" do
      expect {
        post check_out_path, params: check_out_data
      }.must_differ "Rental.count", 1

      # expect(customers(:customer_one).videos_checked_out_count).must_equal 1
      # expect(videos(:fake_vid).available_inventory).must_equal 8

      must_respond_with :ok

      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal REQUIRED_ATTRS
    end

  end

  describe "check in" do

  end
end
