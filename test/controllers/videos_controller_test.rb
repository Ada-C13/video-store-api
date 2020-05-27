require "test_helper"

describe VideosController do
  REQUIRED_video_FIELDS = ["title", "release_date", "available_inventory"].sort
  describe "index" do
    it "responds with JSON and success" do
      get videos_path

      expect(response.header['Content-Type']).must_include 'json'
      must_respond_with :ok
    end

    it "responds with an array of video hashes" do
      # Act
      get videos_path
  
      # Get the body of the response
      body = JSON.parse(response.body)
  
      # Assert
      expect(body).must_be_instance_of Array
      body.each do |video|
        expect(video).must_be_instance_of Hash
  
        required_video_attrs = ["title", "release_date", "available_inventory"]
  
        expect(video.keys.sort).must_equal required_video_attrs.sort
      end
    end

    it "will respond with an empty array when there are no videos" do
      # Arrange
      Video.destroy_all
  
      # Act
      get customers_path
      body = JSON.parse(response.body)
  
      # Assert
      expect(body).must_be_instance_of Array
      expect(body).must_equal []
      expect(status).must_equal 200  #added this
    end
  end


  describe "create" do
    let(:video_data) {
            {
              video: {
                title: "my movie",
                release_date: "2020",
                available_inventory: 3
              }
            }
          }


    it "can create a new video" do
      expect {
        post videos_path, params: video_data
      }.must_differ "Video.count", 1

      check_response(expected_type: Hash, expected_status: :created)
    end

    it "will respond with bad_request for invalid data" do
      video[:video][:title] = nil

      expect {
        # Act
        post videos_path, params: video_data

      # Assert
      }.wont_change "Video.count"
    
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body["errors"].keys).must_include "title"
    end

  end

  describe "show" do
    it "responds with JSON and success and correct video data" do
      video = Video.first

      gets video_path(video.id)
    
      body = check_response(expected_type: Hash)

      
      expect(body.keys.sort).must_equal REQUIRED_video_FIELDS
      expect(body["id"]).must_equal existing_video.id
      expect(body["title"]).must_equal existing_video.title
      expect(body["release_date"]).must_equal existing_video.release_date
      expect(body["available_inventory"]).must_equal existing_video.available_inventory
      puts "this is the body #{body}"
    end

    it "responds with JSON, not found, and errors when looking for non-extant pet" do
      get video_path(-1)

      body = check_response(expected_type: Hash, expected_status: :not_found)
      expect(body["ok"]).must_equal false
      expect(body["errors"]).must_include "Not Found"
    end
  end
end



# describe PetsController do

#   REQUIRED_PET_FIELDS = ["id", "name", "species", "age", "owner"].sort

#   def check_response(expected_type:, expected_status: :success)
#     must_respond_with expected_status
#     expect(response.header['Content-Type']).must_include 'json'

#     body = JSON.parse(response.body)
#     expect(body).must_be_kind_of expected_type
#     return body
#   end


#   describe "create" do
#     let(:pet_data) {
#       {
#         pet: {
#           name: "Stinker",
#           species: "Dog",
#           age: 13,
#           owner: "Grace"
#         }
#       }
#     }

#     it "can create a new pet" do
#       expect {
#         post pets_path, params: pet_data
#       }.must_differ "Pet.count", 1

#       check_response(expected_type: Hash, expected_status: :created)
#     end

#     it "will respond with bad_request for invalid data" do
#       # Arrange - using let from above
#       # Our PetsController test should just test generically
#       # for any kind of invalid data, so we will randomly pick
#       # the age attribute to invalidate
#       pet_data[:pet][:age] = nil

#       expect {
#         # Act
#         post pets_path, params: pet_data

#       # Assert
#       }.wont_change "Pet.count"
    
#       body = check_response(expected_type: Hash, expected_status: :bad_request)
#       expect(body["errors"].keys).must_include "age"
#     end

#   end

#   describe "show" do


#     it "responds with JSON, not found, and errors when looking for non-extant pet" do
#       get pet_path(-1)

#       body = check_response(expected_type: Hash, expected_status: :not_found)
#       expect(body["ok"]).must_equal false
#       expect(body["errors"]).must_include "Not Found"
#     end
#   end

# end

