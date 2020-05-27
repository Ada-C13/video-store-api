# require "test_helper"
# def check_response(expected_type:, expected_status: :success)
#   must_respond_with expected_status
#   expect(response.header['Content-Type']).must_include 'json'

#   body = JSON.parse(response.body)
#   expect(body).must_be_kind_of expected_type
#   return body
# end

# describe CustomersController do

#   REQUIRED_video_FIELDS = ["id", "name", "registered_at", "available_inventory"].sort


#   describe "index" do
#     it "responds with JSON and success" do
#       get videos_path

#       expect(response.header['Content-Type']).must_include 'json'
#       must_respond_with :ok
#     end

#     it "responds with an array of video hashes" do
#       # Act
#       get videos_path
  
#       # Get the body of the response
#       body = JSON.parse(response.body)
  
#       # Assert
#       expect(body).must_be_instance_of Array
#       body.each do |video|
#         expect(video).must_be_instance_of Hash
  
#         required_video_attrs = ["id","title", "release_date", "available_inventory"]
  
#         expect(video.keys.sort).must_equal required_video_attrs.sort
#       end
#     end

#     it "will respond with an empty array when there are no videos" do
#       # Arrange
#       Video.destroy_all
  
#       # Act
#       get customers_path
#       body = JSON.parse(response.body)
  
#       # Assert
#       expect(body).must_be_instance_of Array
#       expect(body).must_equal []
#       expect(status).must_equal 200  #added this
#     end
#   end


#   describe "create" do
#     let(:video_data) {
#       {
#         video: {
#           title: "new title",
#           release_date: Time.now,
#           available_inventory: 9,
#         }
#       }
#     }

 
#     it "can create a new pet" do
#       expect {
#         post videos_path, params: video_data
#       }.must_differ "Video.count", 1

#       check_response(expected_type: Hash, expected_status: :created)
#     end

#     it "will respond with bad_request for invalid data" do
#       # Arrange - using let from above
#       # Our videosController test should just test generically
#       # for any kind of invalid data, so we will randomly pick
#       # the age attribute to invalidate
#       video_data[:video][:available_inventory] = nil

#       expect {
#         # Act
#         post videos_path, params: video_data

#       # Assert
#       }.wont_change "Video.count"
    
#       body = check_response(expected_type: Hash, expected_status: :bad_request)
#       expect(body["errors"].keys).must_include "available_inventory"
#     end

#   end

#   describe "show" do
#     it "responds with JSON and success and correct video data" do
#       videos = Video.all
#       video = videos.first

#       get video_path(video.id)
#       body = check_response(expected_type: Hash)
      
#       expect(body.keys.sort).must_equal REQUIRED_video_FIELDS.sort
#       expect(body["id"]).must_equal video.id
#       expect(body["title"]).must_equal video.title
#       expect(body["release_date"]).must_equal "1979-01-18"
#       expect(body["available_inventory"]).must_equal video.available_inventory
#     end

#     it "responds with JSON, not found, and errors when looking for non-extant video" do
#       get video_path(-1)

#       body = check_response(expected_type: Hash, expected_status: :not_found)
#       expect(body["ok"]).must_equal false
#       expect(body["errors"]).must_include "Not Found"
#     end
#   end

#end
