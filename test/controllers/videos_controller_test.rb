require "test_helper"

describe VideosController do
  VIDEO_FIELDS = ["id", "title", "release_date", "available_inventory"].sort
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
        expect(video).must_be_instance_of hash
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

      # 
    end
  end
end
