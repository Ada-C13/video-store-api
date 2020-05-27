require "test_helper"

describe VideosController do
  VIDEO_FIELDS = ["title", 'overview', "release_date", 'total_inventory', "available_inventory"].sort
  describe "index" do 
    it "responds with JSON and success" do
      get videos_path

      expect(response.header["Content-Type"]).must_include 'json'
      must_respond_with :ok
    end

    it "returns all the proper fields for a list of videos" do
      # Act 
      get videos_path

      # Get the body of the response as an array of hash
      body = JSON.parse(response.body)

      # Assert
      expect(body).must_be_instance_of Array
      
      body.each do |video|
        expect(video).must_be_instance_of Hash
        expect(video.keys.sort).must_equal VIDEO_FIELDS
      end
    end

    it "return an empty array if there is no video exists" do
      Video.destroy_all
      # Act 
      get videos_path

      # Get the body of the response as an array of hash
      body = JSON.parse(response.body)
      
      expect(body).must_be_instance_of Array
      expect(body.length).must_equal 0

    end
  end

  describe "show" do 
    it "returns a hash with the proper fields for an existing video" do
      video = videos(:video1)

      # Act 
      get video_path(video.id)

      # Assert
      must_respond_with :success

      body = JSON.parse(response.body)

      expect(response.header["Content-Type"]).must_include 'json'

      expect(body).must_be_instance_of Hash
      expect(body.keys.sort).must_equal VIDEO_FIELDS
    end

    # Edge case
    it "returns a 404 response with joson for non-existent video" do
      get video_path(-1)

      must_respond_with :not_found
      body = JSON.parse(response.body)
      expect(body).must_be_instance_of Hash
      expect(body['errors']).must_equal ['Not Found']
    end
  end

  # describe 'create' do
  #   it "return the status 200 when the video is created successfully" do
      
  #   end
  # end
end
