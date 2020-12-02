require "test_helper"

describe RentalsController do
#   before do
#     @customer = Customer.create(name: "Daenerys Targaryen", address: "some big house", registered_at: Date.parse("28 May 2020"), city: "Valyria", state: "Essos", postal_code: "98122", videos_checked_out_count: 2)
#     @video = Video.create(title: "Legally Blonde", overview: "Elle Woods becomes a lawyer", release_date: Date.parse("13 July 2001"), total_inventory: 6, available_inventory: 5)
#   end

#   describe "checkout" do
#     # let(:rental_data) {
#     #   {
#     #     customer_id: @customer.id,
#     #     video_id: @video.id,
#     #   }
#     # }

#     it "can create a new rental" do
#       rental_data =
#         {
#           customer_id: @customer.id,
#           video_id: @video.id,
#         }
    
#       expect {
#         post checkout_path, params: rental_data
#       }.must_differ "Rental.count", 1

#       must_respond_with :success
#     end

#     it "gives bad_request status when user gives bad data" do
#       rental_data[:customer_id] = nil
#       expect {
#         post videos_path, params: video_data
#       }.wont_change "Video.count"

#       must_respond_with :bad_request

#       expect(response.header['Content-Type']).must_include 'json'

#       body = JSON.parse(response.body)
      
#       expect(body['errors'].keys).must_include 'title'

#     end
#   end
  

#   describe "checkin" do

#   end
end
