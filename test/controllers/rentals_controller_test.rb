require "test_helper"

describe RentalsController do
  let(:customer) { customers(:Jane) }
  let(:video_with_stock) { videos(:Jumanji) }
  let(:video_with_no_stock) { videos(:Shrek) }
  let(:rental) { {customer_id: customer.id, video_id: video_with_stock.id} }

  describe "check out" do
    let(:bogus_customer_rental) { { customer_id: -1, video_id: video_with_stock.id } }
    let(:bogus_video_rental) { {customer_id: customer.id, video_id: -1} }

    it "creates a new Rental object on a successful checkout" do
      assert_difference("Rental.count") do
        post check_out_url, params: rental, as: :json
      end
      must_respond_with :success
    end

    it "does not create a new Rental object with an invalid customer id" do
      assert_no_difference("Rental.count") do
        post check_out_url, params: bogus_customer_rental, as: :json
      end
      must_respond_with :not_found

      response = JSON.parse(@response.body)
      assert_equal ["Not Found"], response['errors']
    end

    it "does not create a new Rental object with an invalid video id" do
      assert_no_difference("Rental.count") do
        post check_out_url, params: bogus_video_rental, as: :json
      end
      must_respond_with :not_found

      response = JSON.parse(@response.body)
      assert_equal ["Not Found"], response['errors']
    end

    it "does not create a new Rental object with a video that has no stock" do
      assert_no_difference("Rental.count") do
        post check_out_url, params: { video_id: video_with_no_stock.id, customer_id: customer.id }, as: :json
      end
      must_respond_with :not_found

      response = JSON.parse(@response.body)
      assert_equal ["no inventory available"], response['errors']
    end
  end

  describe "check in" do

    before do
      post check_out_url, params: rental, as: :json
      @rental = Rental.last
    end

    it "checks in an existing valid Rental and +1 to video inventory, -1 to customer video rentals" do
      expect(@rental.customer.videos_checked_out_count).must_equal 1
      post check_in_url, params: { video_id: @rental.video.id, customer_id: @rental.customer.id }, as: :json
      expect(@rental.customer.videos_checked_out_count).must_equal 0

      must_respond_with :success
    end

    it "does not check in a non-existing Rental, does not modify customer video count or video inventory count" do
      assert_no_difference("customer.videos_checked_out_count") do
        post check_in_url, params: { video_id: -1, customer_id: -1 }, as: :json
      end
      must_respond_with :not_found

      response = JSON.parse(@response.body)
      assert_equal ["Not Found"], response['errors']
    end
  end
end
