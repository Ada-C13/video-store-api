require "test_helper"

describe RentalsController do
  let(:phony_customer) {Customer.create(
    name: "Shelley Rocha",
    registered_at: "Wed, 29 Apr 2015 07:54:14 -0700",
    address: "Ap #292-5216 Ipsum Rd.",
    city: "Hillsboro",
    state: "OR",
    postal_code: "24309",
    phone: "(322) 510-8695",
    videos_checked_out_count: 1
  )}
  let(:phony_video) {Video.create(
    title: "a",
    overview: "this is a transformative movie",
    release_date: "2020-01-01",
    total_inventory: 20,
    available_inventory: 19
  )}
  let(:rental_fixture){rental(:rental_1)}
  

  describe "checkout" do
    let(:good_rental_data){
         {
         customer_id: phony_customer.id,
         video_id: phony_video.id
         }
     }
     let(:bad_rental_data){
      {
        customer_id: "horse",
        video_id: "yaz"
       }
     }
      
      it "good data: responds with success, created new rental" do
        expect {
          post check_out_path, params: good_rental_data
        }.must_differ 'Rental.count', 1 
        must_respond_with :created
      end
      it "good data: correct http response" do
        post check_out_path, params: good_rental_data
        body = JSON.parse(response.body)
        expect(response.header['Content-Type']).must_include 'json'
      end
      it "bad_data: responds with bad request" do
        post check_out_path, params: bad_rental_data
        must_respond_with :bad_request
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


  # describe "checkin" do
  #   it "responds with success when passed in valid params" do

  #     expect {
  #       post check_in_path, params: rental_data
  #     }.must_differ 'Rental.count', -1
  #     body = JSON.parse(response.body)

  #     expect(response.header['Content-Type']).must_include 'json'
  #     must_respond_with :ok

  #     # customer.reload
  #     # movie.reload
  #     expect(rental_data.customer.videos_checked_out_count).must_equal 0
  #     expect(rental_data.available_inventory).must_equal 20
  #   end
  # end
end
