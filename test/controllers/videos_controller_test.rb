require "test_helper"


describe VideosController do
  VIDEO_FIELDS = ["id", "title", "overview", "total_inventory", "available_inventory", "release_date"].sort

  def check_response(expected_type:, expected_status: :success)
    must_respond_with expected_status
    expect(response.header['Content-Type']).must_include 'json'

    body = JSON.parse(response.body)
    expect(body).must_be_kind_of expected_type
    return body
  end

  describe "index" do
    it "must get index" do
      get videos_path
      check_response(expected_type: Array)
    end

    it "will return all proper fields for a list of customers" do
      get videos_path

      body = check_response(expected_type: Array)

      body.each do |video|
        expect(video).must_be_instance_of Hash
        expect(video.keys.sort).must_equal VIDEO_FIELDS
      end
    end

    it "returns an empty array if no customers exist" do
      Video.destroy_all

      get videos_path

      body = check_response(expected_type: Array)
      expect(body.length).must_equal 0
    end
  end

  describe "show" do
    it "will return a hash with the proper fields for an existing video" do
      video = videos(:jurassicpark)
      # act
      get video_path(video.id)
      body = check_response(expected_type: Hash, expected_status: :ok)
      # body = JSON.parse(response.body)
      # must_respond_with :ok
      # expect(response.header['Content-Type']).must_include 'json'
      # expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal VIDEO_FIELDS
    end

    it "will return a 404 request with json for a non-existant pet" do
      get video_path(-1)
      body = check_response(expected_type: Hash, expected_status: :not_found)
      # must_respond_with :not_found
      # body = JSON.parse(response.body)
      # expect(body).must_be_instance_of Hash
      expect(body['ok']).must_equal false
      expect(body['message']).must_equal 'Not found'
    end
  end

  describe "create" do
    let(:video_data) {
      {
        video: {
          title: "Titanic",
          overview: "You jump I jump!",
          release_date: "1997-12-19",
          total_inventory: 5,
          available_inventory: 5,
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
      # Arrange - using let from above
      # Need to add validation
      video_data[:video][:title] = nil

      expect {
        post videos_path, params: video_data
      }.wont_change "Video.count"
    
      body = check_response(expected_type: Hash, expected_status: :bad_request)
      expect(body["errors"].keys).must_include "title"
    end

  end
end


# describe VideosController do
#   VIDEO_FIELDS = ["id", "title", "overview", "total_inventory", "available_inventory", "release_date"].sort

#   describe "index" do
#     it "must get index" do
#       get videos_path
#       must_respond_with :success
#       expect(response.header['Content-Type']).must_include 'json'
#     end

#     it "will return all proper fields for a list of customers" do
#       get videos_path

#       body = JSON.parse(response.body)

#       expect(body).must_be_instance_of Array

#       body.each do |video|
#         expect(video).must_be_instance_of Hash
#         expect(video.keys.sort).must_equal VIDEO_FIELDS
#       end
#     end

#     it "returns an empty array if no customers exist" do
#       Video.destroy_all

#       get videos_path

#       body = JSON.parse(response.body)

#       expect(body).must_be_instance_of Array
#       expect(body.length).must_equal 0
#     end
#   end

#   describe "show" do
#     it "will return a hash with the proper fields for an existing video" do
#       video = videos(:jurassicpark)
#       # act
#       get video_path(video.id)
#       body = JSON.parse(response.body)
#       must_respond_with :ok
#       expect(response.header['Content-Type']).must_include 'json'
#       expect(body).must_be_instance_of Hash
#       expect(body.keys.sort).must_equal VIDEO_FIELDS
#     end

#     it "will return a 404 request with json for a non-existant pet" do
#       get video_path(-1)
#       must_respond_with :not_found
#       body = JSON.parse(response.body)
#       expect(body).must_be_instance_of Hash
#       expect(body['ok']).must_equal false
#       expect(body['message']).must_equal 'Not found'
#     end

#   end
# end
