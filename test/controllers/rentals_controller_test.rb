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
    before do
      Customer.create(
        name: "Evelynn",
        registered_at: "Wed, 29 Apr 2015 14:54:14 UTC +00:00",
        address: "13133 111th Dr Se",
        city: "Monroe",
        state: "WA",
        postal_code: "98989",
        phone: "425 425 44 44",
        videos_checked_out_count: 0
      )

      Video.create(
        title: "Cinderella",
        overview: "After her father unexpectedly dies, young Ella (Lily James) finds herself at the mercy of her cruel stepmother (Cate Blanchett) and stepsisters, who reduce her to scullery maid. Despite her circumstances, she refuses to despair.",
        release_date: "2015-03-06",
        total_inventory: 5,
        available_inventory: 5
      )

      @customer = Customer.find_by(name: "Evelynn")
      @video = Video.find_by(title: "Cinderella")

      @rental_data = {
        video_id: @video.id,
        customer_id: @customer.id
      }
    end

    it "can create a rental" do
      expect{post rentals_path, params: @rental_data}.must_differ "Rental.count", 1
      check_response(expected_type: Hash)
    end

    it "will return JSON with the following keys: customer_id, video_id, due_date, videos_checked_out_count, available_inventory" do
      json_fields = ["customer_id", "video_id", "due_date", "videos_checked_out_count", "available_inventory"].sort
      
      post rentals_path, params: @rental_data
      body = check_response(expected_type: Hash)

      rental = Rental.last
      customer = Customer.find_by(name: "Evelynn")
      video = Video.find_by(title: "Cinderella")

    
      expect(body.keys.sort).must_equal json_fields
      expect(body["customer_id"]).must_equal customer.id
      expect(body["video_id"]).must_equal video.id
      expect(body["videos_checked_out_count"]).must_equal customer.videos_checked_out_count
      expect(body["available_inventory"]).must_equal video.available_inventory
    end

    it "increase the customer's videos_checked_out_count by one" do
      expect(@customer.videos_checked_out_count).must_equal 0
      
      post rentals_path, params: @rental_data
      customer = Customer.find_by(name: "Evelynn")
      expect(customer.videos_checked_out_count).must_equal 1
    end

    it "decrease the video's available_inventory by one" do
      expect(@video.available_inventory).must_equal 5

      post rentals_path, params: @rental_data
      video = Video.find_by(title: "Cinderella")
      expect(video.available_inventory).must_equal 4
    end

    it "will respond with 404: Not Found if the customer does not exist" do
      @rental_data[:customer_id] = -1
      expect{post check_out_path, params: @rental_data}.wont_change "Rental.count", 1
      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["errors"]).must_equal ["Not Found"]
    end

    it "will respond with 404: Not Found if the video does not exist" do
      @rental_data[:video_id] = -1
      expect{post check_out_path, params: @rental_data}.wont_change "Rental.count", 1
      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["errors"]).must_equal ["Not Found"]
    end

    it "will respond with 400: Bad Request if the video does not have any available inventory before check out" do
      rental_data = {
        video_id: videos(:maleficent).id,
        customer_id: customers(:nataliya).id
      }
      expect{post check_out_path, params: rental_data}.wont_change "Rental.count", 1
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body["errors"]).must_equal ["No available copies of the video available"]
    end

    it "will respond with 404: Not Found if the customer is already renting this video title" do
      post rentals_path, params: @rental_data
      expect{post check_out_path, params: @rental_data}.wont_change "Rental.count", 1
      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["errors"].keys).must_include "video_id"
    end
  end

  describe "check-in" do
    before do
      Customer.create(
        name: "Evelynn",
        registered_at: "Wed, 29 Apr 2015 14:54:14 UTC +00:00",
        address: "13133 111th Dr Se",
        city: "Monroe",
        state: "WA",
        postal_code: "98989",
        phone: "425 425 44 44",
        videos_checked_out_count: 0
      )

      Video.create(
        title: "Cinderella",
        overview: "After her father unexpectedly dies, young Ella (Lily James) finds herself at the mercy of her cruel stepmother (Cate Blanchett) and stepsisters, who reduce her to scullery maid. Despite her circumstances, she refuses to despair.",
        release_date: "2015-03-06",
        total_inventory: 5,
        available_inventory: 5
      )

      @customer = Customer.find_by(name: "Evelynn")
      @video = Video.find_by(title: "Cinderella")

      @rental_data = {
        video_id: @video.id,
        customer_id: @customer.id
      }

      post check_out_path, params: @rental_data
    end
    
    it "will destroy the instance of rental" do
      expect{post check_in_path, params: @rental_data}.must_differ "Rental.count", -1 
      check_response(expected_type: Hash)
    end

    it "will return JSON with the following keys: customer_id, video_id, videos_checked_out_count, available_inventory" do
      json_fields = ["customer_id", "video_id", "videos_checked_out_count", "available_inventory"].sort
      
      post check_in_path, params: @rental_data
      body = check_response(expected_type: Hash)
      
      customer = Customer.find_by(id: @rental_data[:customer_id])
      video = Video.find_by(id: @rental_data[:video_id])

      expect(body.keys.sort).must_equal json_fields
      expect(body["customer_id"]).must_equal customer.id
      expect(body["video_id"]).must_equal video.id
      expect(body["videos_checked_out_count"]).must_equal customer.videos_checked_out_count
      expect(body["available_inventory"]).must_equal video.available_inventory
    end

    it "will decrease the customer's videos_checked_out_count by one" do
      customer = Customer.find_by(id: @rental_data[:customer_id])
      expect(customer.videos_checked_out_count).must_equal 1
      post check_in_path, params: @rental_data
      customer = Customer.find_by(id: @rental_data[:customer_id])
      expect(customer.videos_checked_out_count).must_equal 0
    end

    it "increase the video's available_inventory by one" do
      video = Video.find_by(id: @rental_data[:video_id])
      expect(video.available_inventory).must_equal 4
      post check_in_path, params: @rental_data
      video = Video.find_by(id: @rental_data[:video_id])
      expect(video.available_inventory).must_equal 5
    end

    it "will respond with 404: Not Found if the customer does not exist" do
      @rental_data[:customer_id] = -1
      expect{post check_in_path, params: @rental_data}.wont_change "Rental.count"
      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["errors"]).must_equal ["Not Found"]
    end

    it "will respond with 404: Not Found if the video does not exist" do
      @rental_data[:video_id] = -1
      expect{post check_in_path, params: @rental_data}.wont_change "Rental.count"
      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["errors"]).must_equal ["Not Found"]
    end
  end
end
