require "test_helper"

describe RentalsController do
  let(:rental_data){rental(:rental_1)}
  let(:customer_fixture) {customer(:customer_1)}
  let(:video_fixture) {video(:video_1)}


  # let(:rental_data) {
  #   {
  #     customer_id: customer(:customer_1).id,
  #     video_id: video(:video_1).id,
  #   }
  # }

  # let(:movie) {
  #   movies(:the_departed)
  # }

  describe "checkout" do
    it "responds with success" do
      expect(rental_data.customer.videos_checked_out_count).must_equal 1
      expect(rental_data.video.available_inventory).must_equal 19

      expect {
        post check_out_path, params: rental_data
      }.must_differ 'Rental.count', 1 

      body = JSON.parse(response.body)


      expect(body["id"]).must_be_instance_of Integer
      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok

      # rental_data.customer.reload
      # movie.reload
      expect(customer.videos_checked_out_count).must_equal 1
      expect(movie.available_inventory).must_equal 24
    end
  end



  # describe "create" do
  #   let(:rental_info) {
  #     {
  #       video_id: Video.first.id,
  #       customer_id: Customer.first.id
  #     }
  #   }

  #   it "can creates a new rental" do
  #     expect {
  #       post rental_data, params: rental_info
  #     }.must_differ 'Rental.count', 1

  #     must_respond_with :created
  #   end

  # end


  describe "checkin" do
    it "responds with success when passed in valid params" do

      expect {
        post check_in_path, params: rental_data
      }.must_differ 'Rental.count', -1
      body = JSON.parse(response.body)

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok

      # customer.reload
      # movie.reload
      expect(rental_data.customer.videos_checked_out_count).must_equal 0
      expect(rental_data.available_inventory).must_equal 20
    end
  end
end
